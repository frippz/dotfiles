if [ -d $HOME/.rbenv ]; then
  case $OSTYPE in
    *darwin*)
      eval "$(rbenv init -)"
      ;;
    linux*)
      if [ -d $HOME/.rbenv/bin ]; then
        PATH=$HOME/.rbenv/bin:$PATH
        eval "$(rbenv init -)"
      fi
      ;;
  esac
fi
