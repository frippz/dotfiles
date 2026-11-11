// Pure estimates over usage readings. No `$`, no clock: every function takes
// the readings and the times it needs, so tests drive it directly.
import type { HudResets, HudSample } from '../types'

export const MIN = 60_000
export const HOUR = 60 * MIN
export const DAY = 24 * HOUR
export const WEEK = 7 * DAY
export const FIVE_HOURS = 5 * HOUR

type Key = 'w' | 'f'

/** Readings sorted by time, one per timestamp. */
export function tidy(xs: readonly HudSample[]): HudSample[] {
  const byT = new Map<number, HudSample>()
  for (const s of xs) byT.set(s.t, s)
  return [...byT.values()].sort((a, b) => a.t - b.t)
}

/** Index of the first reading after the last drop (a reset); -1 when none. */
export function afterLastDrop(xs: readonly HudSample[], key: Key): number {
  for (let i = xs.length - 1; i > 0; i--) {
    if (xs[i]![key] < xs[i - 1]![key] - 0.5) return i
  }
  return -1
}

/**
 * When the current window began: the later of the last drop in the readings
 * and `resetsAt − length` (resets also happen mid-window).
 */
export function windowStart(
  xs: readonly HudSample[],
  key: Key,
  resetsAt: number | undefined,
  length: number,
): number | undefined {
  const i = afterLastDrop(xs, key)
  const drop = i >= 0 ? xs[i]!.t : undefined
  const byReset = resetsAt === undefined ? undefined : resetsAt - length
  if (drop === undefined && byReset === undefined) return xs[0]?.t
  return Math.max(drop ?? -Infinity, byReset ?? -Infinity)
}

/** The readings of the window that starts at `start`. */
export function windowOf(xs: readonly HudSample[], start: number | undefined): HudSample[] {
  return start === undefined ? [...xs] : xs.filter(s => s.t >= start)
}

/** The reading at `t`, linear between readings; undefined outside them. */
export function valueAt(xs: readonly HudSample[], t: number, key: Key): number | undefined {
  const first = xs[0]
  const last = xs[xs.length - 1]
  if (!first || !last || t < first.t || t > last.t) return undefined
  let lo = 0
  let hi = xs.length - 1
  while (hi - lo > 1) {
    const mid = (lo + hi) >> 1
    if (xs[mid]!.t <= t) lo = mid
    else hi = mid
  }
  const a = xs[lo]!
  const b = xs[hi]!
  if (b.t === a.t) return b[key]
  return a[key] + ((b[key] - a[key]) * (t - a.t)) / (b.t - a.t)
}

/**
 * Spend in %/h over the `span` before `t`, clipped to the window's first
 * reading; undefined with less than `minSpan` to go on.
 */
export function paceAt(
  win: readonly HudSample[],
  t: number,
  span: number,
  minSpan: number,
  key: Key = 'w',
): number | undefined {
  const first = win[0]
  if (!first) return undefined
  const from = Math.max(first.t, t - span)
  if (t - from < minSpan) return undefined
  const a = valueAt(win, from, key)
  const b = valueAt(win, t, key)
  if (a === undefined || b === undefined) return undefined
  return (b - a) / ((t - from) / HOUR)
}

/** Trailing-day pace at the last reading: spending since a baseline ~24 h back. */
export function dayPace(win: readonly HudSample[]): number | undefined {
  const last = win[win.length - 1]
  return last ? paceAt(win, last.t, DAY, HOUR) : undefined
}

/** Hours until the weekly quota is gone at the trailing-day pace. */
export function zeroIn(win: readonly HudSample[]): number | undefined {
  const last = win[win.length - 1]
  const pace = dayPace(win)
  if (!last || pace === undefined) return undefined
  const left = Math.max(0, 100 - last.w)
  return pace > 0 ? left / pace : Infinity
}

export const PAUSE_GAP = 30 * MIN
export const PAUSE_FLAT = 60 * MIN
export const WORK_HALF_LIFE = 3 * HOUR

/**
 * Working intervals between readings: a gap over 30 min is a pause, and so
 * is an unbroken flat run of 60 min or more. Short flat runs are work, since
 * readings are whole percents.
 */
export function workingIntervals(xs: readonly HudSample[]): { dt: number; du: number }[] {
  const intervals = []
  for (let i = 1; i < xs.length; i++) {
    const dt = xs[i]!.t - xs[i - 1]!.t
    intervals.push({ dt, du: xs[i]!.w - xs[i - 1]!.w, isPause: dt > PAUSE_GAP })
  }
  let i = 0
  while (i < intervals.length) {
    if (intervals[i]!.isPause || intervals[i]!.du !== 0) {
      i++
      continue
    }
    let j = i
    let run = 0
    while (j < intervals.length && !intervals[j]!.isPause && intervals[j]!.du === 0) {
      run += intervals[j]!.dt
      j++
    }
    if (run >= PAUSE_FLAT) for (let k = i; k < j; k++) intervals[k]!.isPause = true
    i = j
  }
  return intervals.filter(one => !one.isPause).map(({ dt, du }) => ({ dt, du }))
}

/**
 * %/h while working: the mean over working intervals, weighted by recency
 * with a half-life of 3 h of working time.
 */
export function workingRate(win: readonly HudSample[]): number | undefined {
  const intervals = workingIntervals(win)
  let tau = 0
  let spent = 0
  let hours = 0
  for (let i = intervals.length - 1; i >= 0; i--) {
    const { dt, du } = intervals[i]!
    const weight = 0.5 ** ((tau + dt / 2) / WORK_HALF_LIFE)
    spent += weight * du
    hours += (weight * dt) / HOUR
    tau += dt
  }
  if (tau < 30 * MIN || hours <= 0) return undefined
  return spent / hours
}

/** Working hours left in the weekly quota at the working rate. */
export function hoursOfWork(win: readonly HudSample[]): number | undefined {
  const last = win[win.length - 1]
  const rate = workingRate(win)
  if (!last || rate === undefined) return undefined
  const left = Math.max(0, 100 - last.w)
  return rate > 0 ? left / rate : Infinity
}

export type HudFiveHour = {
  used: number
  /** Milliseconds from the last reading to the reset. */
  toReset: number | undefined
  /** %/h over the last hour. */
  pace: number | undefined
  /** The last hour's pace empties it before the reset. */
  isRed: boolean
}

export function fiveHour(xs: readonly HudSample[], resetsAt: number | undefined): HudFiveHour | undefined {
  const start = windowStart(xs, 'f', resetsAt, FIVE_HOURS)
  const win = windowOf(xs, start)
  const last = win[win.length - 1]
  if (!last) return undefined
  const pace = paceAt(win, last.t, HOUR, 15 * MIN, 'f')
  const toReset = resetsAt === undefined ? undefined : Math.max(0, resetsAt - last.t)
  const left = Math.max(0, 100 - last.f)
  const isRed =
    pace !== undefined && pace > 0 && toReset !== undefined && (left / pace) * HOUR < toReset
  return { used: last.f, toReset, pace, isRed }
}

export const HORIZONS = [3, 6, 12, 24, 48] as const
export type HudQuantiles = { h: number; n: number; p10: number; p50: number; p90: number }

/** Used when history holds too few cases to calibrate a horizon. */
export const DEFAULT_SPREAD = { p10: 0.35, p50: 1, p90: 1.65 }

function quantile(sorted: readonly number[], q: number): number {
  const at = (sorted.length - 1) * q
  const lo = Math.floor(at)
  const hi = Math.ceil(at)
  return sorted[lo]! + (sorted[hi]! - sorted[lo]!) * (at - lo)
}

/** Splits readings at every drop: one run per window. */
export function segments(xs: readonly HudSample[]): HudSample[][] {
  const out: HudSample[][] = []
  let run: HudSample[] = []
  for (const s of xs) {
    const prev = run[run.length - 1]
    if (prev && s.w < prev.w - 0.5) {
      out.push(run)
      run = []
    }
    run.push(s)
  }
  if (run.length) out.push(run)
  return out
}

/**
 * Per horizon (3–48 h): actual spend over the horizon divided by what the
 * trailing-day pace at its start predicted, as p10/p50/p90 over history.
 */
export function calibrate(xs: readonly HudSample[]): HudQuantiles[] {
  const ratios = new Map<number, number[]>(HORIZONS.map(h => [h, []]))
  for (const seg of segments(xs)) {
    const first = seg[0]!
    const last = seg[seg.length - 1]!
    let prevT = -Infinity
    for (const s of seg) {
      if (s.t - prevT < 30 * MIN || s.t - first.t < 6 * HOUR) continue
      prevT = s.t
      const pace = paceAt(seg, s.t, DAY, 6 * HOUR)
      if (pace === undefined || pace < 0.05) continue
      for (const h of HORIZONS) {
        const t1 = s.t + h * HOUR
        if (t1 > last.t) break
        ratios.get(h)!.push((valueAt(seg, t1, 'w')! - s.w) / (pace * h))
      }
    }
  }
  return HORIZONS.map(h => {
    const list = ratios.get(h)!.sort((a, b) => a - b)
    if (list.length < 8) return { h, n: list.length, ...DEFAULT_SPREAD }
    return { h, n: list.length, p10: quantile(list, 0.1), p50: quantile(list, 0.5), p90: quantile(list, 0.9) }
  })
}

type Q = 'p10' | 'p50' | 'p90'

export function ratioAt(cal: readonly HudQuantiles[], h: number, q: Q): number {
  const first = cal[0]
  const last = cal[cal.length - 1]
  if (!first || !last) return DEFAULT_SPREAD[q]
  if (h <= first.h) return first[q]
  if (h >= last.h) return last[q]
  for (let i = 1; i < cal.length; i++) {
    const b = cal[i]!
    if (h <= b.h) {
      const a = cal[i - 1]!
      return a[q] + ((b[q] - a[q]) * (h - a.h)) / (b.h - a.h)
    }
  }
  return last[q]
}

export type HudProjectionPoint = { t: number; p10: number; p50: number; p90: number }
export type HudProjection = {
  points: HudProjectionPoint[]
  /** When each projection reaches 100 %, before `end`; p90 spend is the earliest. */
  zero: { early?: number; mid?: number; late?: number }
}

/** The weekly projection from the last reading to `end`, by calibrated spread. */
export function project(
  win: readonly HudSample[],
  cal: readonly HudQuantiles[],
  end: number,
): HudProjection | undefined {
  const last = win[win.length - 1]
  const pace = dayPace(win)
  if (!last || pace === undefined || pace <= 0 || end <= last.t) return undefined
  const points: HudProjectionPoint[] = []
  const zero: HudProjection['zero'] = {}
  const step = 15 * MIN
  for (let t = last.t; ; t = Math.min(end, t + step)) {
    const h = (t - last.t) / HOUR
    const y = (q: Q) => last.w + pace * h * ratioAt(cal, h, q)
    const point = { t, p10: y('p10'), p50: y('p50'), p90: y('p90') }
    if (zero.early === undefined && point.p90 >= 100) zero.early = t
    if (zero.mid === undefined && point.p50 >= 100) zero.mid = t
    if (zero.late === undefined && point.p10 >= 100) zero.late = t
    points.push({ t, p10: Math.min(100, point.p10), p50: Math.min(100, point.p50), p90: Math.min(100, point.p90) })
    if (t >= end || zero.late !== undefined) break
  }
  return { points, zero }
}

/** Trailing 3 h burn rate at each reading of the window. */
export function burnSeries(win: readonly HudSample[]): { t: number; r: number }[] {
  const out = []
  for (const s of win) {
    const r = paceAt(win, s.t, 3 * HOUR, 30 * MIN)
    if (r !== undefined) out.push({ t: s.t, r })
  }
  return out
}

/** Moves a reset that has passed forward by whole windows. */
export function rollForward(resetsAt: number | undefined, at: number, length: number): number | undefined {
  if (resetsAt === undefined) return undefined
  let t = resetsAt
  while (t <= at) t += length
  return t
}

export type HudWeekly = {
  start: number | undefined
  reset: number | undefined
  win: HudSample[]
  used: number
  left: number
  zeroIn: number | undefined
  work: number | undefined
  projection: HudProjection | undefined
  burn: { t: number; r: number }[]
  /** %/h that lasts exactly to the reset. */
  budget: number | undefined
  rateNow: number | undefined
}

export type HudModel = {
  /** The last reading's time: everything is drawn as of it. */
  at: number
  weekly: HudWeekly
  five: HudFiveHour | undefined
  /** Readings of the last day, for the five-hour sawtooth. */
  day: HudSample[]
  fiveReset: number | undefined
}

export function model(samples: readonly HudSample[], resets: HudResets): HudModel | undefined {
  const xs = tidy(samples)
  const last = xs[xs.length - 1]
  if (!last) return undefined
  const reset = rollForward(resets.weekly, last.t, WEEK)
  const start = windowStart(xs, 'w', reset, WEEK)
  const win = windowOf(xs, start)
  const end = reset ?? last.t + 2 * DAY
  const burn = burnSeries(win)
  const left = Math.max(0, 100 - last.w)
  const fiveReset = resets.fiveHour !== undefined && resets.fiveHour > last.t ? resets.fiveHour : undefined
  return {
    at: last.t,
    weekly: {
      start,
      reset,
      win,
      used: last.w,
      left,
      zeroIn: zeroIn(win),
      work: hoursOfWork(win),
      projection: project(win, calibrate(xs), end),
      burn,
      budget: reset === undefined ? undefined : left / Math.max(1 / 60, (reset - last.t) / HOUR),
      rateNow: burn[burn.length - 1]?.r,
    },
    five: fiveHour(xs, fiveReset),
    day: xs.filter(s => s.t >= last.t - DAY),
    fiveReset,
  }
}
