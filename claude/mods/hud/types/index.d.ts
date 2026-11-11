/** One reading of the plan's usage: weekly (`w`) and five-hour (`f`) percent used. */
export type HudSample = { t: number; w: number; f: number }

/** When each window resets, in epoch milliseconds, as the response headers said. */
export type HudResets = { weekly?: number; fiveHour?: number }

/** The readings the band and pane draw from, all from one source. */
export type HudData = {
  source: 'app' | 'headers'
  samples: HudSample[]
  resets: HudResets
}

/** The main thread's last response: when it landed and its prompt-cache tokens. */
export type HudCache = { t: number; read: number; total: number }

declare module 'claude-code' {
  interface PluginState {
    hud: {
      data: Shaped<HudData | null>
      cache: HudCache | null
      now: number
    }
  }
}
