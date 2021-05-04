if [ -e ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi

export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# Set BAT_THEME based on TERM_THEME
case "$TERM_THEME" in
  "SolarizedLight")
  export BAT_THEME="Solarized (light)"
  ;;

  "OneHalfLight")
  export BAT_THEME="OneHalfLight"
  ;;

  *)
  export BAT_THEME="gruvbox-dark"
  ;;
esac
