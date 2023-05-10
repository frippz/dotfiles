if [ -d $HOME/.nodenv ]; then
  case $OSTYPE in 
    *darwin*)
      eval "$(nodenv init -)"
      ;;
    linux*)
      if [ -d $HOME/.nodenv/bin ]; then
        PATH=$HOME/.nodenv/bin:$PATH
        eval "$(nodenv init -)"
      fi
  esac
fi
