#!/usr/bin/env zsh
#
# Install mise using the official installer (self-updating via `mise self-update`)

source $HOME/.dotfiles/zsh/msg.zsh

if ! [ -x $HOME/.local/bin/mise ]; then

  msg_info "Installing mise"

  curl -fsSL https://mise.run | sh

else

  msg_info "mise is already installed! 👍"

fi

exit 0
