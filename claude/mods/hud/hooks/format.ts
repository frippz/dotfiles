// Pure text formatting for the band and pane.
import { HOUR, MIN } from './estimate'

const DAYS = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']

/** A span in hours as the band reads it: `59m`, `20h`, `1d 18h`. */
export function span(hours: number): string {
  if (!Number.isFinite(hours)) return '∞'
  const minutes = Math.max(0, Math.round(hours * 60))
  if (minutes < 60) return `${minutes}m`
  const h = Math.round(minutes / 60)
  if (h < 24) return `${h}h`
  const d = Math.floor(h / 24)
  const rest = h % 24
  return rest === 0 ? `${d}d` : `${d}d ${rest}h`
}

/** Milliseconds as hours and minutes: `4h04m`, `59m`. */
export function hm(ms: number): string {
  const minutes = Math.max(0, Math.round(ms / MIN))
  if (minutes < 60) return `${minutes}m`
  return `${Math.floor(minutes / 60)}h${String(minutes % 60).padStart(2, '0')}m`
}

export function msSpan(ms: number): string {
  return span(ms / HOUR)
}

export function pct(n: number): string {
  return `${Math.round(n)}%`
}

export function rate(n: number): string {
  return `${n.toFixed(1)}%/h`
}

const two = (n: number) => String(n).padStart(2, '0')

/** `Wed 17:35`, local time. */
export function dayTime(t: number): string {
  const d = new Date(t)
  return `${DAYS[d.getDay()]} ${two(d.getHours())}:${two(d.getMinutes())}`
}

/** `Tue 6`, local date. */
export function dayDate(t: number): string {
  const d = new Date(t)
  return `${DAYS[d.getDay()]} ${d.getDate()}`
}

/** Local midnight at or before `t`. */
export function midnight(t: number): number {
  const d = new Date(t)
  d.setHours(0, 0, 0, 0)
  return d.getTime()
}

/** Local midnight on the day after `t`'s, DST-safe. */
export function nextMidnight(t: number): number {
  const d = new Date(midnight(t))
  d.setDate(d.getDate() + 1)
  return d.getTime()
}
