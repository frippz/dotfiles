#!/usr/bin/env zsh

source $HOME/.dotfiles/zsh/msg.zsh

# Global packages to install with npm (merged from default-packages)
PACKAGES=(
  "neovim"
  "npm-check-updates"
  "wrangler"
  "yarn"
)

set -e

# Check if Node.js is available (via Homebrew)
if command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
  msg_info "Node.js found. Installing global packages..."

  for PACKAGE in ${PACKAGES[@]}; do
    if npm list -g "$PACKAGE" >/dev/null 2>&1; then
      msg_done "$PACKAGE is already installed globally. Skipping..."
    else
      msg_info "Installing $PACKAGE globally"
      npm install -g "$PACKAGE"
    fi
  done

  msg_done "Global package installation complete"
else
  msg_fail "Node.js not found. Please install Node.js via Homebrew first."
  exit 1
fi
