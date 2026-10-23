#!/usr/bin/env zsh
#
# Install mise on Linux systems (macOS gets it from the Brewfile)

source $HOME/.dotfiles/zsh/msg.zsh

case "$OSTYPE" in
  *linux*)
    if ! command -v mise >/dev/null 2>&1 && ! [ -x $HOME/.local/bin/mise ]; then

      msg_info "Installing mise"

      curl -fsSL https://mise.run | sh

    else

      msg_info "mise is already installed! 👍"

    fi
    ;;

  *darwin*)
    msg_warn "Skipping mise installation (installed via Homebrew)"
    ;;
esac

exit 0
