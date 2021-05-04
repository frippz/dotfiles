if [ -e ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi

export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

if [ "$TERM_THEME" = "SolarizedLight" ]; then
  export BAT_THEME="Solarized (light)"
else
  export BAT_THEME="gruvbox-dark"
fi
