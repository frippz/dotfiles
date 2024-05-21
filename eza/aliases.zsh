if command -v eza >/dev/null 2>&1 ; then
  alias eza="eza --icons=always"

  # Hijack ls
  alias ll="eza --long --level=4 --no-permissions"
  alias lt="eza --tree --long --level=4 --no-permissions"
fi
