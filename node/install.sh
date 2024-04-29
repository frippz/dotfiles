#!/usr/bin/env zsh

source $HOME/.dotfiles/zsh/msg.zsh

GLOBAL_VERSION="20.12.2"

VERSIONS=(
  "20.12.2"
)

PLUGINS=(
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
  "pnpm"
  "yarn"
)

NODENV_HOME="$HOME/.nodenv"
DIR="$(cd "$(dirname "$0")" && pwd)"

set -e

# Install nodenv
if command -v git > /dev/null 2>&1; then
  if ! command -v nodenv > /dev/null 2>&1; then
    msg_done "Installing nodenv using git"

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
    msg_warn "nodenv is already installed. Skipping…"
  fi
else
  msg_fail "git not found. Aborting..."
  exit 1
fi

if command -v nodenv > /dev/null 2>&1; then

  msg_done "Install Node versions using nodenv and set ${GLOBAL_VERSION} as global"

  for VERSION in ${VERSIONS[@]}; do
    nodenv install $VERSION --skip-existing
  done

  nodenv global $GLOBAL_VERSION
  nodenv rehash

fi

# Install nodenv plugins
if [ -d $HOME/.nodenv ]; then
  msg_done "Installing nodenv plugins"
  for PLUGIN in ${PLUGINS[@]}; do
    PLUGIN_NAME=$(echo $PLUGIN | sed -E 's/.*\/([^/]+)\.git$/\1/')
    if [ ! -d "$(nodenv root)/plugins/$PLUGIN_NAME" ]; then
      git clone $PLUGIN $(nodenv root)/plugins/$PLUGIN_NAME
    else
      msg_info "$PLUGIN_NAME is already installed"
    fi
  done
fi

# Check for npm
if command -v npm > /dev/null 2>&1; then
  msg_done "Installing Node packages"

  # Install packages globally
  for PACKAGE in ${PACKAGES[@]}; do
    if npm list -g --depth=0 | grep -q "$PACKAGE@"; then
      msg_info "$PACKAGE is already installed. Skipping..."
    else
      msg_info "Installing $PACKAGE"
      npm i -g $PACKAGE
    fi
  done
else
  msg_fail "Node is not installed. Skipping..."
  exit 1
fi
