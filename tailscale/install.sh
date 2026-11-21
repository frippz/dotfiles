#!/usr/bin/env zsh
#
# Install Tailscale on Linux systems

source $HOME/.dotfiles/zsh/msg.zsh

case "$OSTYPE" in
  *linux*)
    if ! command -v tailscale >/dev/null 2>&1 ; then

      msg_info "Installing Tailscale"

      # Adds Tailscale's package repo for the detected distro and installs it (uses sudo)
      # Fetch first so a failed download isn't piped to sh as an empty script
      installer=$(curl -fsSL https://tailscale.com/install.sh) \
        && sh -c "$installer" \
        || { msg_fail "Tailscale installation failed"; exit 1; }

      msg_info "Run 'sudo tailscale up' to connect this machine to your tailnet"

    else

      msg_info "Tailscale is already installed! 👍"

    fi
    ;;

  *darwin*)
    msg_warn "Skipping Tailscale installation (Linux only)"
    ;;
esac

exit 0
