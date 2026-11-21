#!/usr/bin/env zsh
#
# Install bob on Linux systems

source $HOME/.dotfiles/zsh/msg.zsh

case "$OSTYPE" in
  *linux*)
    if ! [ -d $HOME/.local/share/bob/nvim-bin ]; then

      msg_info "Installing bob"

      # Fetch first so a failed download isn't piped to bash as an empty script
      installer=$(curl -fsSL https://raw.githubusercontent.com/MordechaiHadad/bob/master/scripts/install.sh) \
        && bash -c "$installer" \
        || { msg_fail "bob installation failed"; exit 1; }

    else

      msg_info "bob is already installed! 👍"

    fi
    ;;

  *)
    msg_info "Not on Linux. Skipping bob..."
    ;;
esac
