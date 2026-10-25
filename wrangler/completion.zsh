# wrangler completion, cached since starting wrangler is slow, and regenerated
# whenever pnpm reinstalls the wrangler shim (i.e. on upgrade)
if (( $+commands[wrangler] )); then
  () {
    local cache="$XDG_CACHE_HOME/zsh/wrangler-completion.zsh"

    if [[ ! -s $cache || $commands[wrangler] -nt $cache ]]; then
      mkdir -p ${cache:h}
      wrangler complete zsh >| $cache 2>/dev/null
    fi

    source $cache
  }
fi
