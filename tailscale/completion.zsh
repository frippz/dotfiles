# tailscale completion, cached and regenerated whenever tailscale is updated
if (( $+commands[tailscale] )); then
  () {
    local cache="$XDG_CACHE_HOME/zsh/tailscale-completion.zsh"

    if [[ ! -s $cache || $commands[tailscale] -nt $cache ]]; then
      mkdir -p ${cache:h}
      tailscale completion zsh >| $cache 2>/dev/null
    fi

    source $cache
  }
fi
