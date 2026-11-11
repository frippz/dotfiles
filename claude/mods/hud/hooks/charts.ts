// Pure SVG builders for the pane. Colors are the reference dataviz palette,
// light and dark, as CSS custom properties on :root (painted with the chart
// surface so the frame shows no white margin).
import { DAY, HOUR, type HudModel } from './estimate'
import { dayDate, dayTime, midnight, nextMidnight, pct, rate, span } from './format'
import type { HudSample } from '../types'

const STYLE = `<style>
:root{color-scheme:light;--surface:#fcfcfb;--ink:#0b0b0b;--ink2:#52514e;--muted:#898781;--grid:#e1e0d9;--axis:#c3c2b7;--blue:#2a78d6;--red:#e34948;background:var(--surface)}
@media (prefers-color-scheme: dark){:root{color-scheme:dark;--surface:#1a1a19;--ink:#f0efec;--ink2:#c3c2b7;--grid:#2c2c2a;--axis:#383835;--blue:#3987e5;--red:#e66767}}
.bg{fill:var(--surface)}
text{font:11px system-ui,-apple-system,"Segoe UI",sans-serif;fill:var(--muted)}
.ink{fill:var(--ink)}.ink2{fill:var(--ink2)}.bold{font-weight:600;font-size:12px}.warn{fill:var(--red)}
.grid{stroke:var(--grid);stroke-width:1}.axis{stroke:var(--axis);stroke-width:1}
.limit{stroke:var(--muted);stroke-width:1;stroke-dasharray:2 3}
.reset{stroke:var(--muted);stroke-width:1;stroke-dasharray:3 3}
.budget{stroke:var(--ink2);stroke-width:1.5;stroke-dasharray:6 4}
.line{fill:none;stroke:var(--blue);stroke-width:2;stroke-linejoin:round}
.area{fill:var(--blue);fill-opacity:.14}
.over{fill:var(--red);fill-opacity:.28}
.p50{fill:none;stroke:var(--red);stroke-width:2;stroke-dasharray:6 4}
.band{fill:var(--red);fill-opacity:.16}
.dot{fill:var(--blue);stroke:var(--surface);stroke-width:2}
.hit{fill:var(--ink);fill-opacity:0}.hit:hover{fill-opacity:.07}
</style>`

const esc = (s: string) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
const f1 = (n: number) => (Math.round(n * 10) / 10).toString()

type Frame = { w: number; h: number; l: number; r: number; t: number; b: number; x0: number; x1: number; y0: number; y1: number }

function scales(f: Frame) {
  const x = (t: number) => f.l + ((t - f.x0) / (f.x1 - f.x0 || 1)) * (f.w - f.l - f.r)
  const y = (v: number) => f.h - f.b - ((v - f.y0) / (f.y1 - f.y0 || 1)) * (f.h - f.t - f.b)
  return { x, y }
}

function svg(f: Frame, body: string): string {
  return `<svg xmlns="http://www.w3.org/2000/svg" width="${f.w}" height="${f.h}" viewBox="0 0 ${f.w} ${f.h}">${STYLE}<rect class="bg" width="${f.w}" height="${f.h}"/>${body}</svg>`
}

function path(points: readonly [number, number][]): string {
  return points.map(([px, py], i) => `${i ? 'L' : 'M'}${f1(px)} ${f1(py)}`).join('')
}

/** Day gridlines at local midnights, labels at noon. */
function dayAxis(f: Frame): string {
  const { x } = scales(f)
  let out = ''
  for (let m = nextMidnight(f.x0 - 1); m <= f.x1; m = nextMidnight(m)) {
    out += `<line class="grid" x1="${f1(x(m))}" x2="${f1(x(m))}" y1="${f.t}" y2="${f.h - f.b}"/>`
  }
  for (let m = midnight(f.x0); m <= f.x1; m = nextMidnight(m)) {
    const noon = m + 12 * HOUR
    if (noon < f.x0 || noon > f.x1) continue
    out += `<text x="${f1(x(noon))}" y="${f.h - f.b + 16}" text-anchor="middle">${dayDate(noon)}</text>`
  }
  return out
}

function yGrid(f: Frame, ticks: readonly number[], label: (v: number) => string): string {
  const { y } = scales(f)
  return ticks
    .map(
      v =>
        `<line class="grid" x1="${f.l}" x2="${f.w - f.r}" y1="${f1(y(v))}" y2="${f1(y(v))}"/>` +
        `<text x="${f.l - 6}" y="${f1(y(v) + 4)}" text-anchor="end">${label(v)}</text>`,
    )
    .join('')
}

function resetMark(f: Frame, reset: number | undefined, label = 'reset'): string {
  if (reset === undefined || reset < f.x0 || reset > f.x1) return ''
  const { x } = scales(f)
  const rx = f1(x(reset))
  return (
    `<line class="reset" x1="${rx}" x2="${rx}" y1="${f.t}" y2="${f.h - f.b}"/>` +
    `<text x="${f1(x(reset) + 6)}" y="${f.t + 10}" class="ink2">${label}</text>` +
    `<text x="${f1(x(reset) + 6)}" y="${f.t + 25}">${dayTime(reset)}</text>`
  )
}

/** Hover strips: a <title> per slice of the time axis. */
function hits(f: Frame, slices: number, title: (t: number) => string | undefined): string {
  const { x } = scales(f)
  const width = (f.w - f.l - f.r) / slices
  let out = ''
  for (let i = 0; i < slices; i++) {
    const t = f.x0 + ((i + 0.5) / slices) * (f.x1 - f.x0)
    const text = title(t)
    if (text === undefined) continue
    out += `<rect class="hit" x="${f1(x(f.x0) + i * width)}" y="${f.t}" width="${f1(width)}" height="${f.h - f.t - f.b}"><title>${esc(text)}</title></rect>`
  }
  return out
}

function nearest<T extends { t: number }>(xs: readonly T[], t: number, within: number): T | undefined {
  let best: T | undefined
  for (const s of xs) if (!best || Math.abs(s.t - t) < Math.abs(best.t - t)) best = s
  return best && Math.abs(best.t - t) <= within ? best : undefined
}

export function weeklyChart(m: HudModel, w: number, h: number): string {
  const wk = m.weekly
  const first = wk.win[0]
  const x0 = wk.start ?? first?.t ?? m.at - DAY
  const x1 = Math.max(wk.reset ?? m.at + DAY, m.at)
  const f: Frame = { w, h, l: 44, r: 96, t: 44, b: 26, x0, x1, y0: 0, y1: 100 }
  const { x, y } = scales(f)
  let body = yGrid(f, [25, 50, 75], v => `${v}%`) + dayAxis(f)
  body += `<line class="axis" x1="${f.l}" x2="${f.w - f.r}" y1="${y(0)}" y2="${y(0)}"/>`
  body += `<line class="limit" x1="${f.l}" x2="${f.w - f.r}" y1="${y(100)}" y2="${y(100)}"/>`
  body += `<text x="${f.l - 6}" y="${f1(y(100) + 4)}" text-anchor="end">100%</text>`

  const pts = wk.win.map(s => [x(s.t), y(s.w)] as [number, number])
  const lastPt = pts[pts.length - 1]
  if (lastPt && first) {
    body += `<path class="area" d="${path(pts)}L${f1(lastPt[0])} ${y(0)}L${f1(x(first.t))} ${y(0)}Z"/>`
    body += `<path class="line" d="${path(pts)}"/>`
  }

  const proj = wk.projection
  if (proj && proj.points.length > 1) {
    const upper = proj.points.map(p => [x(p.t), y(p.p90)] as [number, number])
    const lower = proj.points.map(p => [x(p.t), y(p.p10)] as [number, number]).reverse()
    body += `<path class="band" d="${path([...upper, ...lower])}Z"/>`
    body += `<path class="p50" d="${path(proj.points.map(p => [x(p.t), y(p.p50)]))}"/>`
    const z = proj.zero.mid
    if (z !== undefined) {
      const zx = Math.min(f.w - f.r - 60, Math.max(f.l + 60, x(z)))
      body += `<text x="${f1(zx)}" y="${f.t - 26}" text-anchor="middle" class="bold warn">0 · ${dayTime(z)}</text>`
      body += `<text x="${f1(zx)}" y="${f.t - 10}" text-anchor="middle">p50 · band p10–p90</text>`
    } else {
      const lx = Math.min(f.w - f.r - 60, Math.max(f.l + 60, x(proj.points[proj.points.length - 1]!.t)))
      body += `<text x="${f1(lx)}" y="${f.t - 10}" text-anchor="middle">p50 lasts to the reset · band p10–p90</text>`
    }
  }

  body += resetMark(f, wk.reset)
  if (lastPt) {
    const lx = Math.min(f.w - f.r - 40, Math.max(f.l + 40, lastPt[0]))
    body += `<text x="${f1(lx)}" y="${f1(lastPt[1] - 12)}" text-anchor="middle" class="ink bold">${pct(wk.used)} used</text>`
    body += `<circle class="dot" cx="${f1(lastPt[0])}" cy="${f1(lastPt[1])}" r="4"/>`
  }

  body += hits(f, 72, t => {
    if (t <= m.at) {
      const s = nearest(wk.win, t, (f.x1 - f.x0) / 72)
      return s && `${dayTime(s.t)} · ${pct(s.w)} used`
    }
    const p = proj && nearest(proj.points, t, (f.x1 - f.x0) / 72)
    return p && `${dayTime(p.t)} · projected p50 ${pct(p.p50)} (p10–p90 ${pct(p.p10)}–${pct(p.p90)})`
  })
  return svg(f, body)
}

export function burnChart(m: HudModel, w: number, h: number): string {
  const wk = m.weekly
  const x0 = wk.start ?? wk.win[0]?.t ?? m.at - DAY
  const x1 = Math.max(wk.reset ?? m.at + DAY, m.at)
  const peak = Math.max(wk.budget ?? 0, ...wk.burn.map(b => b.r))
  const y1 = Math.max(2, Math.ceil((peak * 1.15) / 2) * 2)
  const f: Frame = { w, h, l: 44, r: 96, t: 12, b: 26, x0, x1, y0: 0, y1 }
  const { x, y } = scales(f)
  let body = yGrid(f, [y1 / 2, y1], v => `${v.toFixed(1)}%/h`) + dayAxis(f)
  body += `<line class="axis" x1="${f.l}" x2="${f.w - f.r}" y1="${y(0)}" y2="${y(0)}"/>`
  body += `<text x="${f.l - 6}" y="${y(0) + 4}" text-anchor="end">0</text>`

  const pts = wk.burn.map(b => [x(b.t), y(Math.max(0, b.r))] as [number, number])
  const first = pts[0]
  const last = pts[pts.length - 1]
  const by = wk.budget === undefined ? undefined : y(Math.min(y1, wk.budget))
  if (first && last) {
    const area = `${path(pts)}L${f1(last[0])} ${y(0)}L${f1(first[0])} ${y(0)}Z`
    if (by !== undefined) {
      body += `<clipPath id="above"><rect x="0" y="0" width="${w}" height="${f1(by)}"/></clipPath>`
      body += `<clipPath id="below"><rect x="0" y="${f1(by)}" width="${w}" height="${f1(h - by)}"/></clipPath>`
      body += `<path class="over" clip-path="url(#above)" d="${area}"/>`
      body += `<path class="area" clip-path="url(#below)" d="${area}"/>`
    } else body += `<path class="area" d="${area}"/>`
    body += `<path class="line" d="${path(pts)}"/>`
  }
  if (by !== undefined && wk.budget !== undefined) {
    body += `<line class="budget" x1="${f.l}" x2="${f.w - f.r}" y1="${f1(by)}" y2="${f1(by)}"/>`
    body += `<text x="${f.w - f.r + 6}" y="${f1(by - 2)}" class="ink2">budget</text>`
    body += `<text x="${f.w - f.r + 6}" y="${f1(by + 12)}">${rate(wk.budget)}</text>`
  }
  if (last && wk.rateNow !== undefined) {
    const isOver = wk.budget !== undefined && wk.rateNow > wk.budget
    body += `<circle class="dot" cx="${f1(last[0])}" cy="${f1(last[1])}" r="4"/>`
    const ly = by === undefined ? last[1] + 4 : last[1] <= by ? Math.min(last[1], by) - 8 : Math.max(last[1], by) + 14
    body += `<text x="${f1(last[0] + 8)}" y="${f1(ly)}" class="bold ${isOver ? 'warn' : 'ink'}">${rate(wk.rateNow)} now</text>`
  }
  body += hits(f, 72, t => {
    const b = nearest(wk.burn, t, (f.x1 - f.x0) / 72)
    if (!b) return undefined
    const vs = wk.budget === undefined ? '' : ` · budget ${rate(wk.budget)}`
    return `${dayTime(b.t)} · ${rate(b.r)} over the trailing 3 h${vs}`
  })
  return svg(f, body)
}

export function fiveHourChart(m: HudModel, w: number, h: number): string {
  const x0 = m.at - DAY
  const x1 = Math.max(m.at, m.fiveReset ?? m.at) + HOUR
  const f: Frame = { w, h, l: 44, r: 96, t: 16, b: 26, x0, x1, y0: 0, y1: 100 }
  const { x, y } = scales(f)
  let body = yGrid(f, [50], v => `${v}%`)
  // Ticks every six hours of local time.
  for (let t = midnight(x0); t <= x1; t += 6 * HOUR) {
    if (t < x0) continue
    const tx = f1(x(t))
    body += `<line class="grid" x1="${tx}" x2="${tx}" y1="${f.t}" y2="${f.h - f.b}"/>`
    if (x(t) > f.l + 30 && x(t) < f.w - f.r - 20) body += `<text x="${tx}" y="${f.h - f.b + 16}" text-anchor="middle">${dayTime(t)}</text>`
  }
  body += `<line class="axis" x1="${f.l}" x2="${f.w - f.r}" y1="${y(0)}" y2="${y(0)}"/>`
  body += `<line class="limit" x1="${f.l}" x2="${f.w - f.r}" y1="${y(100)}" y2="${y(100)}"/>`
  body += `<text x="${f.l - 6}" y="${f1(y(100) + 4)}" text-anchor="end">100%</text>`
  const pts = m.day.map((s: HudSample) => [x(s.t), y(s.f)] as [number, number])
  const first = pts[0]
  const last = pts[pts.length - 1]
  if (first && last) {
    body += `<path class="area" d="${path(pts)}L${f1(last[0])} ${y(0)}L${f1(first[0])} ${y(0)}Z"/>`
    body += `<path class="line" d="${path(pts)}"/>`
    body += `<circle class="dot" cx="${f1(last[0])}" cy="${f1(last[1])}" r="4"/>`
    body += `<text x="${f1(last[0] - 8)}" y="${f1(last[1] - 10)}" text-anchor="end" class="ink bold">${pct(m.day[m.day.length - 1]!.f)}</text>`
  }
  body += resetMark(f, m.fiveReset)
  body += hits(f, 72, t => {
    const s = nearest(m.day, t, (f.x1 - f.x0) / 72)
    return s && `${dayTime(s.t)} · five-hour ${pct(s.f)} used`
  })
  return svg(f, body)
}

/** The pane's headline: `38% left · 0 in 20h (p50) · p10–p90 8h – 1d 1h · resets in 1d 18h`. */
export function headline(m: HudModel): { text: string; isRed: boolean } {
  const wk = m.weekly
  const parts = [`${pct(wk.left)} left`]
  const z = wk.projection?.zero
  const hrs = (t: number | undefined) => (t === undefined ? undefined : span((t - m.at) / HOUR))
  let isRed = false
  if (wk.left <= 0) {
    isRed = true
    parts.push('used up')
  } else if (z?.mid !== undefined) {
    isRed = true
    parts.push(`0 in ${hrs(z.mid)} (p50)`)
    parts.push(`p10–p90 ${hrs(z.early) ?? '?'} – ${hrs(z.late) ?? 'reset'}`)
  } else if (wk.projection) {
    parts.push(z?.early === undefined ? 'lasts to the reset' : `p90 runs out in ${hrs(z.early)}`)
  } else if (wk.zeroIn !== undefined && Number.isFinite(wk.zeroIn)) {
    parts.push(`0 in ${span(wk.zeroIn)}`)
  }
  if (wk.reset !== undefined) parts.push(`resets in ${span((wk.reset - m.at) / HOUR)}`)
  return { text: parts.join(' · '), isRed }
}
