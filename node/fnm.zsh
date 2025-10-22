if [ -d $XDG_DATA_HOME/fnm ]; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi
