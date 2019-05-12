#!/usr/bin/env bash
#

# Versions of Node to install
NODE_VERSIONS=(
  "10.15.0"
)

GLOBAL_NODE="10.15.0"

# Load nodenv if needed
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

set -e

# Check for nodenv and install if it’s not installed
if [ ! -d $HOME/.nodenv/bin ] ; then
  echo ""
  echo "  ✔ nodenv not found. Installing now..."
  echo ""

  git clone https://github.com/nodenv/nodenv.git $HOME/.nodenv

  echo ""
  echo "  ✔ Reloading environment"
  echo ""

  load_nodenv

  echo ""
  echo "  ✔ Installing node-build plugin..."
  echo ""

  git clone https://github.com/nodenv/node-build.git $HOME/.nodenv/plugins/node-build

  echo ""
  echo "  ✔ Installing nodenv-update plugin..."
  echo ""

  git clone https://github.com/nodenv/nodenv-update.git $HOME/.nodenv/plugins/nodenv-update

  echo ""
  echo "  ✔ Attempting to compile dynamic extensions..."
  echo ""

  set +e
  cd $HOME/.nodenv && src/configure && make -C src
  set -e
else
  echo ""
  echo "  ✔ Looks like nodenv is already installed. Awesome!"
  echo ""

  echo ""
  echo "  ✔ Installing versions of Node"
  echo ""

  load_nodenv
  nodenv update

  for NODE_VERSION in ${NODE_VERSIONS[@]} ; do
    nodenv install -s ${NODE_VERSION}
  done

  echo ""
  echo "  ✔ Setting global Node version"
  echo ""
  nodenv global $GLOBAL_NODE
  node -v
fi
