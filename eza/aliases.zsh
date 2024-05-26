if command -v eza >/dev/null 2>&1 ; then
  alias eza="eza --icons=always"

  # Hijack ls
  alias ls="eza"
  alias l="eza -1"
  alias ll="eza --long --header --time-style=relative --no-quotes --no-permissions"
  alias llp="eza --long --header --time-style=relative --no-quotes"
  alias la="ll -a"
  alias lap="eza --long -a"
  alias lt="ll --tree --level=4"
fi
