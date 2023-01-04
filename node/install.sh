#!/usr/bin/env bash

GLOBAL_VERSION="16.19.0"

VERSIONS=(
  "16.19.0"
  "18.12.1"
)

PLUGINS=(
  "git@github.com:nodenv/nodenv-npm-migrate.git"
)

# Packages to install globally with npm
PACKAGES=(
  "ncu"
  "pnpm"
  "pyright"
  "stylelint-lsp"
  "typescript"
  "typescript-language-server"
  "vscode-langservers-extracted"
  "yaml-language-server"
)

set -e

if command -v nodenv > /dev/null 2>&1; then

  echo ""
  echo " ✅ Install Node versions using nodenv and set ${GLOBAL_VERSION} as global"
  echo ""

  for VERSION in ${VERSIONS[@]} ; do
    nodenv install $VERSION --skip-existing
  done

  nodenv global $GLOBAL_VERSION
  nodenv rehash

fi

# Install pyenv plugins
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
    fi
  done
fi

# Check for npm if we’re on OS X
if command -v node >/dev/null 2>&1 ; then
  echo ""
  echo " ✅ Installing Node packages"
  echo ""

  # Install packages globally
  for PACKAGE in ${PACKAGES[@]} ; do
    if npm list -g --depth=0 | grep -q "$PACKAGE@"; then
      echo "    ℹ️  $PACKAGE is already installed. Skipping..."
      echo ""
    else
      echo "  ✅ Installing $PACKAGE"
      npm i -g $PACKAGE
    fi
  done
else
  echo " 🚫 Node is not installed. Skipping..."
fi
