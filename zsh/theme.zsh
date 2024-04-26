# Theme management
#
# Export an environment variable to be used to set
# proper themes wherever needed based on macOS theme

if [[ "$(uname -s)" == "Darwin" ]]; then
  val=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
  if [[ $val == "Dark" ]]; then
    export TERM_THEME="dark"
  else
    export TERM_THEME="light"
  fi
fi

case "$OSTYPE" in
  *linux*)
    if [ "$TERM_THEME" = "light" ]; then
      eval `dircolors $HOME/.dircolors.ansi-light`
    elif [ "$TERM_THEME" = "dark" ]; then
      eval `dircolors $HOME/.dircolors.ansi-dark`
    fi
    ;;
esac
