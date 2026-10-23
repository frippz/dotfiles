#!/usr/bin/env zsh
#
# Claude Code status line: model, directory, context and plan usage.
# Receives session JSON on stdin, see https://code.claude.com/docs/en/statusline

input=$(cat)

field() { jq -r "$1 // empty" <<< "$input" }

# Color a percentage green/yellow/red by how much is used
colorize() {
  local pct=${1%.*}
  local color=32
  (( pct >= 50 )) && color=33
  (( pct >= 80 )) && color=31
  printf '\e[%sm%s%%\e[0m' $color $pct
}

model=$(field '.model.display_name')
dir=$(field '.workspace.current_dir')
ctx=$(field '.context_window.used_percentage')
five=$(field '.rate_limits.five_hour.used_percentage')
five_reset=$(field '.rate_limits.five_hour.resets_at')
week=$(field '.rate_limits.seven_day.used_percentage')

parts=("$model" "${dir/#$HOME/~}")
[[ -n $ctx ]] && parts+=("ctx $(colorize $ctx)")
if [[ -n $five ]]; then
  segment="5h $(colorize $five)"
  [[ -n $five_reset ]] && segment+=" ↻ $(date -r $five_reset +%H:%M 2>/dev/null || date -d @$five_reset +%H:%M)"
  parts+=("$segment")
fi
[[ -n $week ]] && parts+=("7d $(colorize $week)")

print -r -- "${(j: · :)parts}"
