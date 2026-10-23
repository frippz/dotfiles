#!/usr/bin/env zsh

source $HOME/.dotfiles/zsh/msg.zsh
source $HOME/.dotfiles/system/_path.zsh
source $HOME/.dotfiles/node/pnpm.zsh

# Global packages to install with PNPM
PACKAGES=(
  "neovim"
  "wrangler"
)

set -e

# Node and PNPM are managed by mise (see mise/config.toml). The shell isn't
# activated here, so run them through `mise exec` instead of relying on PATH.
if command -v mise >/dev/null 2>&1; then
  msg_info "Installing Node and PNPM with mise"
  mise install node pnpm

  msg_info "Installing global packages..."

  for PACKAGE in ${PACKAGES[@]}; do
    msg_info "Installing (or upgrading) $PACKAGE globally"
    mise exec -- pnpm install -g "$PACKAGE"
  done

  msg_done "Global package installation complete"
else
  msg_fail "mise not found. Run ./mise/install.sh (Linux) or install it via Homebrew (macOS) first."
  exit 1
fi
