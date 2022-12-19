#!/usr/bin/env bash
#
# Install gh extensions

EXTENSIONS=(
  "dlvhdr/gh-dash"
)

if command -v gh >/dev/null 2>&1; then

  for EXTENSION in ${EXTENSIONS[@]}; do
    gh extension install $EXTENSION
  done
fi
