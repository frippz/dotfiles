# Node environment config
export NODE_PATH=$HOME/.npm/lib/node_modules
export PATH=$PATH:$HOME/.npm/bin

# nodenv
if [ -d $HOME/.nodenv/bin ] ; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi
