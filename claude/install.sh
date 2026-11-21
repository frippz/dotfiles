#!/usr/bin/env zsh
#
# Install Claude Code using Anthropic's native installer (self-updating)

source $HOME/.dotfiles/zsh/msg.zsh

if ! [ -x $HOME/.local/bin/claude ]; then

  msg_info "Installing Claude Code"

  # Fetch first so a failed download isn't piped to bash as an empty script
  installer=$(curl -fsSL https://claude.ai/install.sh) \
    && bash -c "$installer" \
    || { msg_fail "Claude Code installation failed"; exit 1; }

else

  msg_info "Claude Code is already installed! 👍"

fi

exit 0
