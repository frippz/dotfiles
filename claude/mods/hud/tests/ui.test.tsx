import { expect, mock, test } from 'claude-code/testing'
import type { TestBody } from 'claude-code/testing'

const H = 3_600_000
const START = Date.UTC(2026, 10, 9, 16)
const NOW = START + 40 * H

/** Header readings stored by an earlier session: 1.5 %/h for 40 h. */
const SAMPLES = Array.from({ length: 161 }, (_, i) => ({
  t: START + i * 15 * 60_000,
  w: Math.floor(i * 0.375),
  f: Math.floor((i % 20) * 2),
}))
const RESETS = { weekly: START + 7 * 24 * H, fiveHour: NOW + 2 * H }

const BAND = {
  plugin: 'hud',
  component: 'AbovePrompt',
  props: {
    hasSurvey: false,
    isCollapsed: false,
    isWorking: false,
    maxRows: 10,
    bodyColumns: 120,
    scroll: { offset: 0, bodyRows: 10 },
    view: {},
  },
} as const

const PANE = {
  plugin: 'hud',
  component: 'Pane',
  requestId: 'hud',
  props: {
    title: 'Weekly quota',
    isFocused: false,
    bodyColumns: 70,
    placement: 'dock',
    scroll: { offset: 0, bodyRows: 40 },
    view: {},
  },
} as const

function world(on: Parameters<TestBody>[1]) {
  mock.clock(on, { now: NOW })
  mock.store(on, { samples: SAMPLES, resets: RESETS })
  mock.env(on, { HOME: '/home/x' })
  on('command.register', () => ({ value: { command: 'quota' } }))
  on('ui.open', () => ({ value: { isPlaced: true } }))
  on('ui.log', () => ({ value: undefined }))
  on('fs.stat', () => {
    throw new Error('ENOENT')
  })
  on('fs.read', () => {
    throw new Error('ENOENT')
  })
  on('session.usage', () => ({ value: { startedAt: NOW, context: { window: 200000 }, rateLimits: [] } }))
  on('session.start', (_, e) => ({ cwd: e.cwd }))
}

test('band and pane draw stored header readings on desktop and terminal', async ($, on) => {
  world(on)
  await $.session.start({ cwd: '/', surface: 'desktop', isInteractive: true })

  for (const surface of ['terminal', 'desktop'] as const) {
    const band = await $.ui.mount({ ...BAND, surface })
    expect((await band.find({ type: 'Text', text: /week \d+%/ })) !== undefined).toBe(true)
    expect(await band.find({ type: 'Text', text: /^0 in / })).toBeDefined()
    expect(await band.find({ key: 'graph' })).toBeDefined()
    await band.unmount()

    const pane = await $.ui.mount({ ...PANE, surface })
    const head = await pane.find({ type: 'Text', text: /left · .*resets in/ })
    expect(head).toBeDefined()
    if (surface === 'desktop') {
      expect(await pane.find({ type: 'Svg' })).toBeDefined()
    }
    await pane.unmount()
  }
})

test('with no readings the pane says so and the band passes', async ($, on) => {
  mock.clock(on, { now: NOW })
  mock.store(on, {})
  mock.env(on, { HOME: '/home/x' })
  on('command.register', () => ({ value: { command: 'quota' } }))
  on('ui.log', () => ({ value: undefined }))
  on('fs.stat', () => {
    throw new Error('ENOENT')
  })
  on('fs.read', () => {
    throw new Error('ENOENT')
  })
  on('session.usage', () => ({ value: { startedAt: NOW, context: { window: 200000 }, rateLimits: [] } }))
  on('session.start', (_, e) => ({ cwd: e.cwd }))
  await $.session.start({ cwd: '/', surface: 'desktop', isInteractive: true })

  for (const surface of ['terminal', 'desktop'] as const) {
    const pane = await $.ui.mount({ ...PANE, surface })
    expect(await pane.find({ type: 'Text', text: /No usage readings yet/ })).toBeDefined()
    await pane.unmount()
  }
})
