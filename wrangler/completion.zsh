# wrangler completion, cached since starting wrangler is slow, and regenerated
# whenever pnpm reinstalls the wrangler shim (i.e. on upgrade)
if (( $+commands[wrangler] )); then
  () {
    local cache="$XDG_CACHE_HOME/zsh/wrangler-completion.zsh"

    if [[ ! -s $cache || $commands[wrangler] -nt $cache ]]; then
      mkdir -p ${cache:h}

      # Only keep real completion scripts: older wranglers without `complete`
      # (or a missing node) print help/errors instead, and sourcing that would
      # run it as commands
      if wrangler complete zsh >| $cache.tmp 2>/dev/null &&
        [[ $(head -n 1 $cache.tmp) == '#compdef wrangler' ]]; then
        mv -f $cache.tmp $cache
      else
        rm -f $cache.tmp $cache
        return
      fi
    fi

    source $cache
  }
fi
