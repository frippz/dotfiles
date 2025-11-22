#!/bin/sh
#
# Install zoxide on Linux systems

source $HOME/.dotfiles/zsh/msg.zsh

case "$OSTYPE" in
  *linux*)
    if ! command -v zoxide >/dev/null 2>&1 ; then

      msg_info "Installing zoxide"

      curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

    else

      msg_info "zoxide is already installed! 👍"

    fi
    ;;

  *darwin*)
    msg_warn "Skipping zoxide installation (Linux only)"
    ;;
esac

exit 0
