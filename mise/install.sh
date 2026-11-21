#!/usr/bin/env zsh
#
# Install mise using the official installer (self-updating via `mise self-update`)

source $HOME/.dotfiles/zsh/msg.zsh

if ! [ -x $HOME/.local/bin/mise ]; then

  msg_info "Installing mise"

  # Fetch first so a failed download isn't piped to sh as an empty script
  installer=$(curl -fsSL https://mise.run) \
    && sh -c "$installer" \
    || { msg_fail "mise installation failed"; exit 1; }

else

  msg_info "mise is already installed! 👍"

fi

exit 0
