#!/usr/bin/env zsh
#
# Install Claude Code using Anthropic's native installer (self-updating)

source $HOME/.dotfiles/zsh/msg.zsh

if ! [ -x $HOME/.local/bin/claude ]; then

  msg_info "Installing Claude Code"

  curl -fsSL https://claude.ai/install.sh | bash

else

  msg_info "Claude Code is already installed! 👍"

fi

exit 0
