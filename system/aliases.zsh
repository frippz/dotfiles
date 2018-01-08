# OS specific aliases
#

case "$OSTYPE" in
  *darwin*)
    # System utils
    alias ls="ls -GF"
    alias l="ls -GF"
    if command -v gdf >/dev/null 2>&1 ; then
      alias df="gdf -PH"
    else
      alias df="df -Ph"
    fi
    alias ic="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"
    ;;

  *linux*)
    # System utils
    alias ls="ls --color -F"
    alias l="ls --color -F"
    alias df="df -H"
    alias free="free -wh"
    ;;
esac


# General aliases
#

# Some nice aliases
alias ll="ls -lh"
alias la="ls -lha"
alias c="clear"
alias x="exit"
alias grep="grep --color"

# Colorize tree if it’s installed
if command -v tree >/dev/null 2>&1 ; then
  alias tree="tree -C"
fi

# Colored cat
if command -v ccat >/dev/null 2>&1 ; then
  alias cat="ccat"
fi

# Nice looking time stamp
alias tstamp="date +%Y%m%d%H%M"

# zsh
alias reload!=". ~/.zshrc"
