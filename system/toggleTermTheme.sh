#!/bin/bash

# Only run on Linux
if [[ "$OSTYPE" != "linux"* ]]; then
  echo "This script does nothing on macOS"
  exit 0
fi

# Toggle the theme (default to dark if unset)
if [ "$TERM_THEME" = "light" ]; then
  export TERM_THEME="dark"
else
  export TERM_THEME="light"
fi

echo "Switched to $TERM_THEME theme"
