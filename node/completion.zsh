# npm completion, cached since generating it takes ~70ms per shell start
if command -v npm > /dev/null 2>&1; then
  () {
    local cache="$XDG_CACHE_HOME/zsh/npm-completion.zsh"

    if [[ ! -s $cache ]]; then
      mkdir -p ${cache:h}
      npm completion >| $cache 2>/dev/null
    fi

    source $cache
  }
fi
