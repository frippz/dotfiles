#!/usr/bin/env zsh
#
# Install fzf on Linux systems from its git repo (distro packages are often
# too old for `fzf --zsh`). On macOS it comes from homebrew/Brewfile.
# Upgrade with: git -C ~/.fzf pull && ~/.fzf/install --bin

source $HOME/.dotfiles/zsh/msg.zsh

case "$OSTYPE" in
  *linux*)
    if ! [ -x $HOME/.fzf/bin/fzf ]; then

      msg_info "Installing fzf"

      # --bin only fetches the binary; shell setup lives in fzf/fzf.zsh
      { [ -d $HOME/.fzf ] || git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf; } \
        && $HOME/.fzf/install --bin \
        || { msg_fail "fzf installation failed"; exit 1; }

    else

      msg_info "fzf is already installed! 👍"

    fi
    ;;

  *darwin*)
    msg_warn "Skipping fzf installation (installed via Homebrew on macOS)"
    ;;
esac

exit 0
