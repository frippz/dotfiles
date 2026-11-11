import { describe, expect, test } from 'claude-code/testing'

import type { HudSample } from '../types'
import { bandParts } from '../hooks/band'
import { headline } from '../hooks/charts'
import {
  DAY,
  HOUR,
  MIN,
  WEEK,
  calibrate,
  fiveHour,
  model,
  windowStart,
  workingIntervals,
  workingRate,
  zeroIn,
} from '../hooks/estimate'
import { hm, span } from '../hooks/format'
import { parseAppHistory } from '../hooks/history'

/** Within `tol` of `want`. */
function near(got: number | undefined, want: number, tol: number) {
  expect(got !== undefined && Math.abs(got - want) <= tol).toBe(true)
}

const T0 = Date.UTC(2026, 10, 2, 16) // a weekly window starts here

/** Readings every 15 min, spending `perHour` while working 9–17 (hours from T0). */
function history(hours: number, perHour = 1, from = T0, w0 = 0): HudSample[] {
  const out: HudSample[] = []
  let w = w0
  for (let t = from; t <= from + hours * HOUR; t += 15 * MIN) {
    const hourOfDay = ((t - from) / HOUR) % 24
    if (t > from && hourOfDay >= 1 && hourOfDay < 9) w += perHour / 4
    out.push({ t, w: Math.floor(w), f: 0 })
  }
  return out
}

describe('window', () => {
  test('starts at the later of the last drop and resetsAt − 7 d', () => {
    const xs = [
      { t: T0, w: 50, f: 0 },
      { t: T0 + HOUR, w: 3, f: 0 },
      { t: T0 + 2 * HOUR, w: 5, f: 0 },
    ]
    expect(windowStart(xs, 'w', T0 + WEEK - DAY, WEEK)).toBe(T0 + HOUR)
    expect(windowStart(xs, 'w', T0 + WEEK + 3 * HOUR, WEEK)).toBe(T0 + 3 * HOUR)
    expect(windowStart(xs, 'w', undefined, WEEK)).toBe(T0 + HOUR)
  })
})

describe('0 in', () => {
  test('quota left over the trailing day pace', () => {
    const xs = [0, 12, 24].map(h => ({ t: T0 + h * HOUR, w: h, f: 0 }))
    near(zeroIn(xs), 76, 1e-5)
  })
  test('no spend lasts forever; too short a run says nothing', () => {
    expect(zeroIn([{ t: T0, w: 5, f: 0 }, { t: T0 + 2 * HOUR, w: 5, f: 0 }])).toBe(Infinity)
    expect(zeroIn([{ t: T0, w: 5, f: 0 }, { t: T0 + 30 * MIN, w: 6, f: 0 }])).toBeUndefined()
  })
})

describe('hours of work', () => {
  test('gaps over 30 min and flat runs of 60 min are pauses; short flat runs are work', () => {
    const at = (m: number, w: number) => ({ t: T0 + m * MIN, w, f: 0 })
    const xs = [at(0, 0), at(15, 1), at(30, 1), at(45, 1), at(60, 2), at(120, 3), at(135, 3), at(150, 3), at(165, 3), at(180, 3), at(195, 4)]
    const work = workingIntervals(xs)
    // 0→60: four intervals of work (flat run of 45 min counts); 60→120: gap;
    // 120→180: flat run of 60 min, pause; 180→195: work.
    expect(work.length).toBe(5)
    expect(work.reduce((a, i) => a + i.dt, 0)).toBe(75 * MIN)
  })
  test('the working rate ignores nights', () => {
    const xs = history(72, 2)
    near(workingRate(xs), 2, 0.5)
    const m = model(xs, { weekly: T0 + WEEK })!
    expect(m.weekly.work).toBeGreaterThan(20)
  })
})

describe('five-hour', () => {
  test('red when the last hour’s pace empties it before the reset', () => {
    const xs = [0, 30, 60].map(m => ({ t: T0 + m * MIN, w: 0, f: 40 + m / 2 }))
    expect(fiveHour(xs, T0 + 5 * HOUR)?.isRed).toBe(true)
    expect(fiveHour(xs, T0 + 90 * MIN)?.isRed).toBe(false)
    expect(fiveHour(xs, T0 + 5 * HOUR)?.toReset).toBe(4 * HOUR)
  })
})

describe('projection', () => {
  test('a steady pace calibrates near 1, and p10 ≤ p50 ≤ p90', () => {
    const xs = history(24 * 6, 1)
    const cal = calibrate(xs)
    for (const q of cal) {
      expect(q.p10).toBeLessThanOrEqual(q.p50)
      expect(q.p50).toBeLessThanOrEqual(q.p90)
    }
    near(cal.find(q => q.h === 24)!.p50, 1, 0.5)
  })
  test('the zero times are ordered and the headline names them', () => {
    const xs = history(48, 4)
    const m = model(xs, { weekly: T0 + WEEK })!
    const z = m.weekly.projection!.zero
    expect(z.early! <= z.mid!).toBe(true)
    expect(headline(m).text).toMatch(/left · 0 in .* \(p50\) · p10–p90 .* · resets in/)
    expect(headline(m).isRed).toBe(true)
  })
})

describe('app history', () => {
  test('keeps only the org with the newest sample', () => {
    const text = JSON.stringify({
      version: 2,
      samples: [
        { t: 3, org: 'a', u: { sd: 30, fh: 3 } },
        { t: 1, org: 'b', u: { sd: 10, fh: 1 } },
        { t: 2, org: 'b', u: { sd: 20, fh: 2 } },
        { t: 4, org: 'b', u: { sd: 21, fh: 2 } },
      ],
    })
    expect(parseAppHistory(text)).toEqual([
      { t: 1, w: 10, f: 1 },
      { t: 2, w: 20, f: 2 },
      { t: 4, w: 21, f: 2 },
    ])
    expect(() => parseAppHistory('{}')).toThrow()
  })
})

describe('band', () => {
  test('reads like the spec, red only for what needs action', () => {
    const xs = history(48, 3)
    const m = model(xs, { weekly: T0 + WEEK, fiveHour: T0 + 50 * HOUR })!
    const at = m.at
    const groups = bandParts(m, { t: at - 2 * MIN, read: 95, total: 100 }, at)
    const text = groups.map(g => g.map(p => p.text).join('')).join(' │ ')
    expect(text).toMatch(/^cache hot 58m │ 5h \d+% · 2h00m │ week \d+% · .* of work · 0 in .* · resets 5d/)
    const red = groups.flat().filter(p => p.tone === 'red').map(p => p.text)
    expect(red.length).toBe(1)
    expect(red[0]).toMatch(/^0 in/)
    const cold = bandParts(undefined, { t: at - 2 * HOUR, read: 1, total: 100 }, at)
    expect(cold[0]!.map(p => p.text).join('')).toBe('cache cold')
    const lowHit = bandParts(undefined, { t: at, read: 50, total: 100 }, at)
    expect(lowHit[0]!.map(p => p.text).join('')).toBe('cache hot 1h · 50% hit')
  })
  test('formats spans', () => {
    expect(span(42.5)).toBe('1d 19h')
    expect(span(0.5)).toBe('30m')
    expect(hm(4 * HOUR + 4 * MIN)).toBe('4h04m')
  })
})
