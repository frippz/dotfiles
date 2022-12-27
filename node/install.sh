#!/usr/bin/env bash

GLOBAL_VERSION="18.12.1"

VERSIONS=(
  "16.19.0"
  "18.12.1"
  )

# Packages to install globally with npm
PACKAGES=(
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
  for VERSION in ${VERSIONS[@]} ; do
    nodenv install $VERSION --skip-existing
  done
  nodenv global $GLOBAL_VERSION
  nodenv rehash
fi

# Check for npm if we’re on OS X
if command -v node >/dev/null 2>&1 ; then
  echo ""
  echo " ✅ Installing Node packages"
  echo ""

  # Install packages globally
  for PACKAGE in ${PACKAGES[@]} ; do
    if npm list -g --depth=0 | grep -q "$PACKAGE@"; then
      echo "   ℹ️  $PACKAGE is already installed. Skipping..."
      echo ""
    else
      echo "  ✅ Installing $PACKAGE"
      npm i -g $PACKAGE
    fi
  done
else
  echo " 🚫 Node is not installed. Skipping..."
fi
