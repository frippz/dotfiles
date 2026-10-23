# npm and pnpm completions, cached since generating them takes ~70ms per shell
# start, and regenerated whenever the binary is updated
() {
  local cmd cache

  for cmd in npm pnpm; do
    (( $+commands[$cmd] )) || continue

    cache="$XDG_CACHE_HOME/zsh/$cmd-completion.zsh"

    if [[ ! -s $cache || $commands[$cmd] -nt $cache ]]; then
      mkdir -p ${cache:h}
      $cmd completion zsh >| $cache 2>/dev/null
    fi

    source $cache
  done
}
