#!/usr/bin/env zsh

source $HOME/.dotfiles/zsh/msg.zsh

# Global packages to install with PNPM
PACKAGES=(
  "@fission-ai/openspec"
  "@github/copilot"
  "neovim"
  "npm-check-updates"
  "wrangler"
  "yarn"
)

set -e

# Check if PNPM is available
if command -v pnpm >/dev/null 2>&1; then
  msg_info "PNPM found. Installing global packages..."

  for PACKAGE in ${PACKAGES[@]}; do
    msg_info "Installing (or upgrading) $PACKAGE globally"
    pnpm install -g "$PACKAGE"
  done

  msg_done "Global package installation complete"
else
  msg_fail "PNPM not found. Please install PNPM via Homebrew first."
  exit 1
fi
