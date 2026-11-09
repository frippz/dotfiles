#!/usr/bin/env zsh
#
# Install GitHub CLI (gh) on Linux systems. On macOS it comes from homebrew/Brewfile.

source $HOME/.dotfiles/zsh/msg.zsh

case "$OSTYPE" in
  *linux*)
    if ! command -v gh >/dev/null 2>&1 ; then

      if ! command -v apt >/dev/null 2>&1 ; then
        msg_warn "Skipping GitHub CLI installation (only apt-based distros are supported, see https://github.com/cli/cli/blob/trunk/docs/install_linux.md)"
        exit 0
      fi

      msg_info "Installing GitHub CLI"

      # Adds GitHub's official apt repo and installs gh (uses sudo); upgrades then come with apt
      keyring=/etc/apt/keyrings/githubcli-archive-keyring.gpg
      sudo mkdir -p -m 755 /etc/apt/keyrings \
        && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee $keyring > /dev/null \
        && sudo chmod go+r $keyring \
        && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
        && echo "deb [arch=$(dpkg --print-architecture) signed-by=$keyring] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
        && sudo apt update \
        && sudo apt install gh -y \
        || { msg_fail "GitHub CLI installation failed"; exit 1; }

      msg_info "Run 'gh auth login' to authenticate"

    else

      msg_info "GitHub CLI is already installed! 👍"

    fi
    ;;

  *darwin*)
    msg_warn "Skipping GitHub CLI installation (installed via Homebrew on macOS)"
    ;;
esac

exit 0
