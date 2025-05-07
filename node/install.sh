#!/usr/bin/env zsh

source $HOME/.dotfiles/zsh/msg.zsh

GLOBAL_VERSION="22.11.0"

VERSIONS=(
  "20.16.0"
  "22.11.0"
)

PLUGINS=(
  "https://github.com/nodenv/node-build.git"
  "https://github.com/nodenv/nodenv-update.git"
  "https://github.com/nodenv/nodenv-npm-migrate.git"
  "https://github.com/ouchxp/nodenv-nvmrc.git"
  "https://github.com/nodenv/nodenv-default-packages.git"
)

# Packages to install globally with npm
PACKAGES=(
  "neovim"
  "npm-check-updates"
  "wrangler"
)

NODENV_HOME="$HOME/.nodenv"
DIR="$(cd "$(dirname "$0")" && pwd)"

set -e

# Install nodenv
if command -v git > /dev/null 2>&1; then
  if ! command -v nodenv > /dev/null 2>&1; then
    msg_info "Installing nodenv using git"

    git clone https://github.com/nodenv/nodenv.git $NODENV_HOME

    # Compile dynamic extensions
    if command -v make > /dev/null 2>&1; then
      msg_info "Compiling dynamic extensions for nodenv"
      cd $NODENV_HOME && src/configure && make -C src
    else
      msg_fail "make not found. Aborting..."
      exit 1
    fi

    source $DIR/nodenv.zsh

    msg_info "Installing node-build"
    mkdir -p "$(nodenv root)"/plugins
    git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
  else
    msg_done "nodenv is already installed. Skipping…"
  fi

  # Symlink default-packages
  if [ ! -f $(nodenv root)/default-packages ]; then
    msg_info "Symlinking $(nodenv root)/default-packages"
    ln -s $HOME/.dotfiles/node/default-packages $(nodenv root)/default-packages
  else
    msg_done "$(nodenv root)/default-packages already present. Moving on..."
  fi
else
  msg_fail "git not found. Aborting..."
  exit 1
fi

# Install nodenv plugins
if [ -d $HOME/.nodenv ]; then
  msg_info "Installing nodenv plugins"
  for PLUGIN in ${PLUGINS[@]}; do
    PLUGIN_NAME=$(echo $PLUGIN | sed -E 's/.*\/([^/]+)\.git$/\1/')
    if [ ! -d "$(nodenv root)/plugins/$PLUGIN_NAME" ]; then
      git clone $PLUGIN $(nodenv root)/plugins/$PLUGIN_NAME
    else
      msg_done "$PLUGIN_NAME is already installed. Skipping..."
    fi
  done
fi

# nodenv update
if command -v nodenv > /dev/null 2>&1; then

  msg_info "Running nodenv update"
  nodenv update

  msg_info "Installing Node versions using nodenv and setting ${GLOBAL_VERSION} as global"

  for VERSION in ${VERSIONS[@]}; do
    if nodenv versions --bare | grep -q "^${VERSION}$"; then
      msg_done "$VERSION is already installed. Skipping..."
    else
      msg_info "Installing version $VERSION"
      nodenv install $VERSION --skip-existing
    fi
  done

  nodenv global $GLOBAL_VERSION
  nodenv rehash

fi
