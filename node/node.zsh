function load_nodenv() {
  # Node environment config
  export NODE_PATH=$HOME/.npm/lib/node_modules
  export PATH=$PATH:$HOME/.npm/bin

  # nodenv
  if [ -d $HOME/.nodenv/bin ] ; then
    export PATH="$HOME/.nodenv/bin:$PATH"
    eval "$(nodenv init -)"
  fi
}

node() {
  unset -f node
  load_nodenv
  node "$@"
}

nodenv() {
  unset -f nodenv
  load_nodenv
  nodenv "$@"
}

nodemon() {
  unset -f nodemon
  load_nodenv
  nodemon "$@"
}

npm() {
  unset -f npm
  load_nodenv
  npm "$@"
}

gulp() {
  unset -f gulp
  load_nodenv
  gulp "$@"
}

yarn() {
  unset -f yarn
  load_nodenv
  yarn "$@"
}
