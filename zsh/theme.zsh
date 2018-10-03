# Theme management
#
# Export an environment variable to be used in Neovim etc to set
# proper themes across the board.

if [ -n "$ITERM_PROFILE" ]; then
  # Match theme with iTerm profile
  export TERM_THEME="$ITERM_PROFILE"
else
  # Fall back to hard-coded theme value
  export TERM_THEME="Gruvbox"
fi

case "$OSTYPE" in
  *linux*)
    if [ "$TERM_THEME" = "SolarizedLight" ]; then
      eval `dircolors $HOME/.dircolors.ansi-light`
    elif [ "$TERM_THEME" = "SolarizedDark" ]; then
      eval `dircolors $HOME/.dircolors.ansi-dark`
    fi
    ;;
esac
