#!/usr/bin/env zsh
#
# Install eza on Linux systems

source $HOME/.dotfiles/zsh/msg.zsh

case "$OSTYPE" in
  *linux*)
    if ! command -v eza >/dev/null 2>&1 ; then

      # Ask for the administrator password upfront
      sudo -v

      msg_info "Installing eza"

      curl -sS https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
      echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
      sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
      sudo apt update && sudo apt install -y eza

    else

      msg_info "eza is already installed! 👍"

    fi
    ;;

  *darwin*)
    msg_warn "Skipping eza installation (Linux only)"
    ;;
esac

exit 0
