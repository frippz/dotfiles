#!/bin/bash

# Only run on Linux
if [[ "$OSTYPE" != "linux"* ]]; then
  echo "This script does nothing on macOS"
  exit 0
fi

# Toggle the theme
if [ "$TERM_THEME" = "dark" ]; then
  export TERM_THEME="light"
else
  export TERM_THEME="dark"
fi

echo "Switched to $TERM_THEME theme"
