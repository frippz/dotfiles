if [ -d $HOME/.rbenv ]; then
  if [ -d $HOME/.rbenv/bin ]; then
    PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
  fi
fi
