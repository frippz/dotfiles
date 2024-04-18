if [ -d $HOME/.nodenv/bin ]; then
  PATH=$HOME/.nodenv/bin:$PATH
  eval "$(nodenv init -)"
fi
