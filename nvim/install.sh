#!/bin/sh

# Install paq-nvim
if [ ! -d ${XDG_DATA_HOME:-$HOME/.local/share/nvim/site/pack} ]; then
  git clone --depth=1 https://github.com/savq/paq-nvim.git "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
else
  echo ""
  echo " ⏭  paq-nvim is already present. Skipping..."
  echo ""
fi

# Install paq-nvim packages
if [ -d ${XDG_DATA_HOME:-$HOME/.local/share/nvim/site/pack} ]; then
  nvim --headless -c "PaqInstall" -c "quit"
fi