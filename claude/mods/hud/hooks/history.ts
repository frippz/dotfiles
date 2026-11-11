// Pure: the desktop app's plan-usage history as readings.
import type { HudSample } from '../types'
import { tidy } from './estimate'

/** Parses the desktop app's history: the org with the newest sample, as readings. */
export function parseAppHistory(text: string): HudSample[] {
  const parsed = JSON.parse(text) as { samples?: unknown }
  if (!Array.isArray(parsed.samples)) throw new Error('no samples array')
  type Raw = { t: number; org: string; u: { sd: number; fh: number } }
  const raw = parsed.samples.filter(
    (s): s is Raw =>
      typeof s?.t === 'number' && typeof s?.org === 'string' && typeof s?.u?.sd === 'number' && typeof s?.u?.fh === 'number',
  )
  const newest = raw.reduce<Raw | undefined>((a, s) => (!a || s.t > a.t ? s : a), undefined)
  if (!newest) return []
  return tidy(raw.filter(s => s.org === newest.org).map(s => ({ t: s.t, w: s.u.sd, f: s.u.fh })))
}
