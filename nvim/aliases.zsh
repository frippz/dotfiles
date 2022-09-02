# Default to neovim (if installed)
if command -v nvim >/dev/null 2>&1 ; then
  alias vi="nvim"
  alias vim="nvim"
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi
