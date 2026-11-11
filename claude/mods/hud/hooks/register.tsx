import { atom, read, update } from 'claude-code'
import type { EngineInterface, Register, SessionRateLimit, TurnUsage } from 'claude-code'

import type { HudCache, HudData, HudResets, HudSample } from '../types'
import { burnChart, fiveHourChart, headline, weeklyChart } from './charts'
import { DAY, HOUR, MIN, model, tidy, type HudModel } from './estimate'
import { dayTime, hm, pct } from './format'
import { bandParts } from './band'
import { parseAppHistory } from './history'

type $ = EngineInterface

const PANE = 'hud'
const TITLE = 'Weekly quota'
const KEEP = 35 * DAY
/** App history older than this is stale: headers take over. */
const STALE = 2 * HOUR

const data = atom({ plugin: 'hud', key: 'data' } as const, null, { shape: 'data-1' })
const cache = atom({ plugin: 'hud', key: 'cache' } as const, null)
const now = atom({ plugin: 'hud', key: 'now' } as const, 0)

let hasLoggedAppFailure = false
let appMtime = -1

// ---- data -----------------------------------------------------------------

function asSamples(value: unknown): HudSample[] {
  if (!Array.isArray(value)) return []
  return value.filter(
    (s): s is HudSample =>
      typeof s === 'object' && s !== null && typeof s.t === 'number' && typeof s.w === 'number' && typeof s.f === 'number',
  )
}

function asResets(value: unknown): HudResets {
  if (typeof value !== 'object' || value === null) return {}
  const { weekly, fiveHour } = value as Record<string, unknown>
  return {
    weekly: typeof weekly === 'number' ? weekly : undefined,
    fiveHour: typeof fiveHour === 'number' ? fiveHour : undefined,
  }
}

async function appPaths($: $): Promise<string[]> {
  const home = (await $.env.get('HOME')) ?? ''
  const xdg = (await $.env.get('XDG_CONFIG_HOME')) || `${home}/.config`
  return [`${xdg}/Claude/plan-usage-history.json`, `${home}/.config/Claude/plan-usage-history.json`, `${home}/Library/Application Support/Claude/plan-usage-history.json`]
}

async function readApp($: $): Promise<{ samples: HudSample[]; mtime: number } | undefined> {
  const tried: string[] = []
  for (const path of [...new Set(await appPaths($))]) {
    try {
      const stat = await $.fs.stat(path)
      const samples = parseAppHistory(await $.fs.read(path))
      return { samples, mtime: stat.mtimeMs }
    } catch (err) {
      tried.push(`${path}: ${err instanceof Error ? err.message : String(err)}`)
    }
  }
  if (!hasLoggedAppFailure) {
    hasLoggedAppFailure = true
    $.ui.log(`hud: no app usage history, using response headers (${tried.join('; ')})`, { to: 'debug' })
  }
  return undefined
}

function resetsFrom(limits: readonly SessionRateLimit[]): HudResets {
  const at = (kind: string) => {
    const iso = limits.find(l => l.kind === kind)?.resetsAt
    const t = iso === undefined ? NaN : Date.parse(iso)
    return Number.isFinite(t) ? t : undefined
  }
  return { weekly: at('seven_day'), fiveHour: at('five_hour') }
}

/** Stores a header reading; skips one that repeats the last within 5 min. */
async function recordHeaders($: $, limits: readonly SessionRateLimit[]): Promise<boolean> {
  const weekly = limits.find(l => l.kind === 'seven_day')
  const five = limits.find(l => l.kind === 'five_hour')
  if (!weekly) return false
  const t = await $.clock.now()
  const resets = resetsFrom(limits)
  const stored = asResets(await $.store.get('resets'))
  await $.store.set('resets', { weekly: resets.weekly ?? stored.weekly, fiveHour: resets.fiveHour ?? stored.fiveHour })
  const samples = asSamples(await $.store.get('samples'))
  const last = samples[samples.length - 1]
  const sample = { t, w: weekly.percentUsed, f: five?.percentUsed ?? last?.f ?? 0 }
  if (last && t - last.t < 5 * MIN && last.w === sample.w && last.f === sample.f) return true
  await $.store.set('samples', tidy([...samples, sample]).filter(s => s.t >= t - KEEP))
  return true
}

/** Picks one source for the readings (never both) and publishes it. */
async function reload($: $): Promise<void> {
  const t = await $.clock.now()
  const app = await readApp($)
  if (app) appMtime = app.mtime
  const resets = asResets(await $.store.get('resets'))
  const headers = asSamples(await $.store.get('samples'))
  const appLast = app?.samples[app.samples.length - 1]
  const isAppFresh = !!app && app.samples.length >= 2 && !!appLast && t - appLast.t < STALE
  const next: HudData =
    isAppFresh || (app && app.samples.length > 0 && headers.length === 0)
      ? { source: 'app', samples: app!.samples, resets }
      : { source: 'headers', samples: headers, resets }
  await update($, data, () => next)
}

async function onTick($: $): Promise<void> {
  const t = await $.clock.now()
  await update($, now, () => t)
  for (const path of await appPaths($)) {
    const stat = await $.fs.stat(path).catch(() => undefined)
    if (stat && stat.mtimeMs !== appMtime) return reload($)
  }
}

async function recordStep($: $, usage: TurnUsage): Promise<void> {
  const t = await $.clock.now()
  const read = usage.cache_read_input_tokens ?? 0
  const total = (usage.input_tokens ?? 0) + read + (usage.cache_creation_input_tokens ?? 0)
  const next: HudCache = { t, read, total }
  await update($, cache, () => next)
  await update($, now, () => t)
  const { rateLimits } = await $.session.usage()
  if (await recordHeaders($, rateLimits)) await reload($)
}

function openPane($: $) {
  return $.ui.open({ id: PANE, title: TITLE })
}

// ---- drawing --------------------------------------------------------------

function modelOf(d: HudData | null): HudModel | undefined {
  return d ? model(d.samples, d.resets) : undefined
}

function chartWidth(columns: number): number {
  return Math.round(Math.max(320, Math.min(960, columns * 8)))
}

// ---- hooks ----------------------------------------------------------------

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    await $.command.register({ name: 'quota', description: 'Show plan quota and cache charts in a pane' })
    const { rateLimits } = await $.session.usage()
    await recordHeaders($, rateLimits)
    await reload($)
    const t = await $.clock.now()
    await update($, now, () => t)
    $.clock.every(MIN, () => void onTick($))
    return next(e)
  })

  on('command.run', { command: 'quota' }, async $ => {
    await openPane($)
    return { text: 'Quota pane opened.' }
  })

  on('session.measure', async ($, e, next) => {
    if (e.changed.includes('rateLimits') && (await recordHeaders($, e.rateLimits))) await reload($)
    return next(e)
  })

  on('turn.step', async function* ($, e, next) {
    const result = yield* next(e)
    if (!e.agentId && result.usage) await recordStep($, result.usage)
    return result
  })

  on('ui.render', { component: 'AbovePrompt' }, async ($, e, next) => {
    if (e.props.hasSurvey) return next(e)
    const m = modelOf(await read($, data))
    const c = await read($, cache)
    const at = Math.max(await read($, now), m?.at ?? 0, c?.t ?? 0)
    const groups = bandParts(m, c, at)
    const below = await next(e)
    if (groups.length === 0) return below
    const { Box, Text, Button } = $.ui.resolve(e)
    return (
      <Box flexDirection="column">
        <Box flexDirection="row" flexWrap="wrap">
          <Text>
            {groups.flatMap((group, i) => [
              ...(i ? [<Text dimColor>{' │ '}</Text>] : []),
              ...group.map(part =>
                part.tone === 'red' ? <Text color="error">{part.text}</Text> : part.tone === 'dim' ? <Text dimColor>{part.text}</Text> : <Text>{part.text}</Text>,
              ),
            ])}{' '}
          </Text>
          {m && <Button key="graph" plain label="graph ↗" onPress={() => void openPane($)} />}
        </Box>
        {below}
      </Box>
    )
  })

  on('ui.render', { component: 'Pane', requestId: PANE }, async ($, e) => {
    const m = modelOf(await read($, data))
    if (e.surface === 'terminal') {
      const { Text } = $.ui.resolve(e)
      if (!m) return <Text dimColor>No usage readings yet.</Text>
      const head = headline(m)
      return <Text color={head.isRed ? 'error' : undefined}>{head.text}</Text>
    }
    const { Box, Text, Svg } = $.ui.resolve(e)
    if (!m) return <Text dimColor>No usage readings yet: they arrive with the next response.</Text>
    const head = headline(m)
    const w = chartWidth(e.props.bodyColumns)
    const five = m.five
    const fiveTitle = five
      ? `Five-hour window: ${pct(five.used)}${five.toReset === undefined ? '' : ` · ${hm(five.toReset)}`}`
      : 'Five-hour window'
    return (
      <Box flexDirection="column" gap={1}>
        <Text color={head.isRed ? 'error' : undefined}>{head.text}</Text>
        <Svg isInteractive width={w} height={Math.round(w * 0.55)} alt={`Weekly quota: ${head.text}`} source={weeklyChart(m, w, Math.round(w * 0.55))} />
        <Text>Burn rate over the trailing 3 hours, against the budget to the reset</Text>
        <Svg isInteractive width={w} height={Math.round(w * 0.38)} alt="Weekly burn rate against the budget to the reset" source={burnChart(m, w, Math.round(w * 0.38))} />
        <Text color={five?.isRed ? 'error' : undefined}>{fiveTitle}</Text>
        <Svg isInteractive width={w} height={Math.round(w * 0.36)} alt={fiveTitle} source={fiveHourChart(m, w, Math.round(w * 0.36))} />
        <Text dimColor>{m.at ? `as of the reading at ${dayTime(m.at)} · source: ${(await read($, data))?.source}` : ''}</Text>
      </Box>
    )
  })
}
