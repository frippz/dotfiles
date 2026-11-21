#!/usr/bin/env zsh
#
# Install eza on Linux systems. On macOS it comes from homebrew/Brewfile.

source $HOME/.dotfiles/zsh/msg.zsh

case "$OSTYPE" in
  *linux*)
    if ! command -v eza >/dev/null 2>&1 ; then

      if ! command -v apt >/dev/null 2>&1 ; then
        msg_warn "Skipping eza installation (only apt-based distros are supported, see https://github.com/eza-community/eza/blob/main/INSTALL.md)"
        exit 0
      fi

      msg_info "Installing eza"

      # Adds the eza apt repo and installs eza (uses sudo); upgrades then come with apt
      keyring=/etc/apt/keyrings/gierens.gpg
      sudo mkdir -p -m 755 /etc/apt/keyrings \
        && curl -fsSL https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor --yes -o $keyring \
        && echo "deb [signed-by=$keyring] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list > /dev/null \
        && sudo chmod 644 $keyring /etc/apt/sources.list.d/gierens.list \
        && sudo apt update \
        && sudo apt install -y eza \
        || { msg_fail "eza installation failed"; exit 1; }

    else

      msg_info "eza is already installed! 👍"

    fi
    ;;

  *darwin*)
    msg_warn "Skipping eza installation (installed via Homebrew on macOS)"
    ;;
esac

exit 0
