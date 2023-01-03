#!/usr/bin/env bash
#
# Install gh extensions

EXTENSIONS=(
  "dlvhdr/gh-dash"
)

source $HOME/.zshrc

if command -v gh >/dev/null 2>&1; then
  for EXTENSION in ${EXTENSIONS[@]}; do
    if ! gh extension list | grep -q  "$EXTENSION"; then
      gh extension install $EXTENSION
    fi
  done
fi
