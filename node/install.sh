#!/usr/bin/env zsh

source $HOME/.dotfiles/zsh/msg.zsh

# Global packages to install with PNPM
PACKAGES=(
  "@anthropic-ai/claude-code"
  "@github/copilot"
  "neovim"
  "npm-check-updates"
  "wrangler"
  "yarn"
)

set -e

# Check if Node.js is available
if command -v node >/dev/null 2>&1 && command -v pnpm >/dev/null 2>&1; then
  msg_info "Node.js found. Installing global packages..."

  for PACKAGE in ${PACKAGES[@]}; do
    if pnpm list -g --depth 0 2>/dev/null | grep -q "$PACKAGE"; then
      msg_done "$PACKAGE is already installed globally. Skipping..."
    else
      msg_info "Installing $PACKAGE globally"
      pnpm install -g "$PACKAGE"
    fi
  done

  msg_done "Global package installation complete"
else
  msg_fail "Node.js not found. Please install Node.js via Homebrew first."
  exit 1
fi
