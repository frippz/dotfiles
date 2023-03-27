#!/bin/sh

# Install paq-nvim
if [ ! -d ${XDG_DATA_HOME:-$HOME/.local/share/nvim/site/pack} ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
else
  echo ""
  echo " ⏭  packer is already present. Skipping..."
  echo ""
fi
