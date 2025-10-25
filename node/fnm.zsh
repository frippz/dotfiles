if [ -d $XDG_DATA_HOME/fnm ]; then
  PATH=$XDG_DATA_HOME/fnm:$PATH
  eval "$(fnm env --use-on-cd --shell zsh)"
fi
