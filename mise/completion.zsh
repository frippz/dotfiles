# mise completion, cached and regenerated whenever mise (self-)updates
if command -v mise > /dev/null 2>&1; then
  () {
    local cache="$XDG_CACHE_HOME/zsh/mise-completion.zsh"

    if [[ ! -s $cache || $commands[mise] -nt $cache ]]; then
      mkdir -p ${cache:h}
      mise completion zsh >| $cache 2>/dev/null
    fi

    source $cache
  }
fi
