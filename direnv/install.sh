#!/usr/bin/env zsh
#
# Install direnv on Linux systems into ~/.local/bin (no sudo). On macOS it
# comes from homebrew/Brewfile.

source $HOME/.dotfiles/zsh/msg.zsh

case "$OSTYPE" in
  *linux*)
    if ! command -v direnv >/dev/null 2>&1 && ! [ -x $HOME/.local/bin/direnv ]; then

      msg_info "Installing direnv"

      # Fetch first so a failed download isn't piped to bash as an empty script
      mkdir -p $HOME/.local/bin
      installer=$(curl -fsSL https://raw.githubusercontent.com/direnv/direnv/master/install.sh) \
        && bin_path=$HOME/.local/bin bash -c "$installer" \
        || { msg_fail "direnv installation failed"; exit 1; }

    else

      msg_info "direnv is already installed! 👍"

    fi
    ;;

  *darwin*)
    msg_warn "Skipping direnv installation (installed via Homebrew on macOS)"
    ;;
esac

exit 0
