#!/usr/bin/env bash

GLOBAL_VERSION="20.12.0"

VERSIONS=(
  "18.18.0"
  "20.11.1"
  "20.12.0"
  "20.12.1"
  "20.12.2"
)

PLUGINS=(
  "https://github.com/nodenv/nodenv-update.git"
  "https://github.com/nodenv/nodenv-npm-migrate.git"
  "https://github.com/ouchxp/nodenv-nvmrc.git"
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
  if [ ! -d "$NODENV_HOME" ]; then
    echo ""
    echo " ✅ Installing nodenv using git"
    echo ""

    git clone https://github.com/nodenv/nodenv.git $NODENV_HOME

    # Compile dynamic extensions
    if command -v make > /dev/null 2>&1; then
      echo "    ℹ️  Compiling dynamic extensions for nodenv"
      echo ""
      cd $NODENV_HOME && src/configure && make -C src
    else
      echo "  ⛔️ make not found. Aborting..."
    fi

    source $DIR/nodenv.zsh

    echo "    ℹ️  Installing node-build"
    echo ""
    mkdir -p "$(nodenv root)"/plugins
    git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
  else
    echo ""
    echo " ⚠️  $NODENV_HOME is already present. Skipping install..."
    echo ""
  fi
else
  echo "  ⛔️ git not found. Aborting..."
fi

if command -v nodenv > /dev/null 2>&1; then

  echo ""
  echo " ✅ Install Node versions using nodenv and set ${GLOBAL_VERSION} as global"
  echo ""

  for VERSION in ${VERSIONS[@]}; do
    nodenv install $VERSION --skip-existing
  done

  nodenv global $GLOBAL_VERSION
  nodenv rehash

fi

# Install nodenv plugins
if [ -d $HOME/.nodenv ]; then
  echo ""
  echo " ✅ Installing nodenv plugins"
  echo ""
  for PLUGIN in ${PLUGINS[@]}; do
    PLUGIN_NAME=$(echo $PLUGIN | sed -E 's/.*\/([^/]+)\.git$/\1/')
    if [ ! -d "$(nodenv root)/plugins/$PLUGIN_NAME" ]; then
      git clone $PLUGIN $(nodenv root)/plugins/$PLUGIN_NAME
    else
      echo "    ℹ️  $PLUGIN_NAME is already installed"
      echo ""
    fi
  done
fi

# Check for npm
if command -v npm > /dev/null 2>&1; then
  echo ""
  echo " ✅ Installing Node packages"
  echo ""

  # Install packages globally
  for PACKAGE in ${PACKAGES[@]}; do
    if npm list -g --depth=0 | grep -q "$PACKAGE@"; then
      echo "    ℹ️  $PACKAGE is already installed. Skipping..."
      echo ""
    else
      echo "  ✅ Installing $PACKAGE"
      echo ""
      npm i -g $PACKAGE
    fi
  done
else
  echo " 🚫 Node is not installed. Skipping..."
  echo ""
fi
