# Theme management
#
# Export an environment variable to be used in Neovim etc to set
# proper themes across the board.

if [ -n "$ITERM_PROFILE" ]; then
  # Match theme with iTerm profile
  export TERM_THEME="$ITERM_PROFILE"
else
  # Fall back to hard-coded theme value
  export TERM_THEME="SolarizedLight"
fi
