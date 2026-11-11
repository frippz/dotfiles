// Pure: the band's runs of text and their tones.
import type { HudCache } from '../types'
import { HOUR, type HudModel } from './estimate'
import { hm, pct, span } from './format'

export const CACHE_TTL = HOUR

export type Part = { text: string; tone?: 'dim' | 'red' }

/** The band's runs: `cache hot 58m │ 5h 6% · 4h14m │ week 38% · …`. */
export function bandParts(m: HudModel | undefined, c: HudCache | null, at: number): Part[][] {
  const groups: Part[][] = []
  if (c) {
    const left = CACHE_TTL - (at - c.t)
    const hit = c.total > 0 ? c.read / c.total : 1
    groups.push(
      left > 0
        ? [
            { text: 'cache ', tone: 'dim' },
            { text: `hot ${span(left / HOUR)}` },
            ...(hit < 0.9 ? [{ text: ' · ', tone: 'dim' as const }, { text: `${pct(hit * 100)} hit` }] : []),
          ]
        : [{ text: 'cache ', tone: 'dim' }, { text: 'cold', tone: 'red' }],
    )
  }
  if (!m) return groups
  const five = m.five
  if (five) {
    const isPast = m.fiveReset !== undefined && at >= m.fiveReset
    const used = isPast ? 0 : five.used
    const toReset = m.fiveReset === undefined || isPast ? undefined : m.fiveReset - Math.max(at, m.at)
    groups.push([
      { text: '5h ', tone: 'dim' },
      { text: pct(used), tone: five.isRed && !isPast ? 'red' : undefined },
      ...(toReset === undefined ? [] : [{ text: ' · ', tone: 'dim' as const }, { text: hm(toReset) }]),
    ])
  }
  const wk = m.weekly
  const isPast = wk.reset !== undefined && at >= wk.reset
  const week: Part[] = [{ text: 'week ', tone: 'dim' }, { text: pct(isPast ? 100 : wk.left) }]
  if (!isPast) {
    if (wk.work !== undefined && Number.isFinite(wk.work)) {
      week.push({ text: ' · ', tone: 'dim' }, { text: `${span(wk.work)} of work` })
    }
    if (wk.left > 0 && wk.zeroIn !== undefined && Number.isFinite(wk.zeroIn)) {
      const zeroAt = m.at + wk.zeroIn * HOUR
      const isBefore = wk.reset === undefined || zeroAt < wk.reset
      if (isBefore) week.push({ text: ' · ', tone: 'dim' }, { text: `0 in ${span(Math.max(0, zeroAt - at) / HOUR)}`, tone: 'red' })
    }
    if (wk.reset !== undefined) week.push({ text: ' · ', tone: 'dim' }, { text: `resets ${span((wk.reset - at) / HOUR)}`, tone: 'dim' })
  }
  groups.push(week)
  return groups
}
