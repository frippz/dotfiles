#!/usr/bin/env zsh
#
# Install zoxide on Linux systems

source $HOME/.dotfiles/zsh/msg.zsh

case "$OSTYPE" in
  *linux*)
    if ! command -v zoxide >/dev/null 2>&1 ; then

      msg_info "Installing zoxide"

      # Fetch first so a failed download isn't piped to bash as an empty script
      installer=$(curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh) \
        && bash -c "$installer" \
        || { msg_fail "zoxide installation failed"; exit 1; }

    else

      msg_info "zoxide is already installed! 👍"

    fi
    ;;

  *darwin*)
    msg_warn "Skipping zoxide installation (Linux only)"
    ;;
esac

exit 0
