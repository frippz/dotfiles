#!/bin/sh

# Install plugins and other tools
if [ -d ${XDG_DATA_HOME:-$HOME/.local/share/nvim/site/pack} ]; then
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
  nvim --headless -c 'TSUpdate' 
  nvim --headless -c 'MasonToolsUpdate'
fi

