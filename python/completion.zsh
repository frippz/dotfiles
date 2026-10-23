# pip completion, cached and regenerated whenever pip is updated
if command -v pip > /dev/null 2>&1; then
  () {
    local cache="$XDG_CACHE_HOME/zsh/pip-completion.zsh"

    if [[ ! -s $cache || $commands[pip] -nt $cache ]]; then
      mkdir -p ${cache:h}
      pip completion --zsh >| $cache 2>/dev/null
    fi

    source $cache
  }
fi
