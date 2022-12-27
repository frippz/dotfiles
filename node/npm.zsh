if command -v nodenv > /dev/null 2>&1; then
  eval "$(npm completion)"
fi

PATH=node_modules/.bin:$PATH
