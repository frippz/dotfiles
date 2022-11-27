#!/usr/bin/env bash

# Packages to install globally with npm
PACKAGES=(
  "stylelint-lsp"
  "typescript"
  "typescript-language-server"
  "vscode-langservers-extracted"
  "pyright"
  "yaml-language-server"
)

set -e

# Check for npm if we’re on OS X
if command -v node >/dev/null 2>&1 ; then
  echo " ✅ Installing Node packages"
  # Install packages globally
  for PACKAGE in ${PACKAGES[@]} ; do
    npm i -g $PACKAGE
  done
else
  echo " 🚫 Node is not installed. Skipping..."
fi
