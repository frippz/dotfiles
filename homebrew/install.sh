#!/bin/sh
#
# Setup required taps and install Homebrew packages using Brewfile

case "$OSTYPE" in
  *darwin*)
    if ! command -v brew >/dev/null 2>&1 ; then

      echo ""
      echo "  ✅ Installing Homebrew"
      echo ""

      bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

      # A fresh install isn't on PATH yet in this shell
      if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

    else

      echo ""
      echo " ⏭  Homebrew is already installed! 👍"
      echo ""

    fi
    ;;
esac

if command -v brew >/dev/null 2>&1 ; then

  # Install from Brewfile
  cd "$(dirname "$0")"
  brew bundle

fi

exit 0
