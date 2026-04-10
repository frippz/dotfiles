#!/usr/bin/env zsh
#
# Install bob on Linux systems

source $HOME/.dotfiles/zsh/msg.zsh

case "$OSTYPE" in
  *linux*)
    if ! [ -d $HOME/.local/share/bob/nvim-bin ]; then

      msg_info "Installing bob"

      curl -fsSL https://raw.githubusercontent.com/MordechaiHadad/bob/master/scripts/install.sh | bash

    else

      msg_info "bob is already installed! 👍"

    fi
    ;;
esac
