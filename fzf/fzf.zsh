# Key bindings and completion. `fzf --zsh` needs fzf 0.48+; older distro
# packages (e.g. Ubuntu's apt fzf) don't have it, so skip quietly there and let
# fzf/install.sh put a current one in ~/.fzf/bin
if command -v fzf >/dev/null 2>&1 ; then
  () {
    local init
    init=$(fzf --zsh 2>/dev/null) && eval "$init"
  }
fi
