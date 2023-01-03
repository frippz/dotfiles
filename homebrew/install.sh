#!/bin/sh
#
# Setup required taps and install Homebrew packages using Brewfile

source $HOME/.zshrc

case "$OSTYPE" in
  *darwin*)
    if ! command -v brew >/dev/null 2>&1 ; then

      echo ""
      echo "  ✅ Installing Homebrew"
      echo ""

      HOMEBREW_PREFIX="/usr/local"

      if [ -d "$HOMEBREW_PREFIX" ]; then
        if ! [ -r "$HOMEBREW_PREFIX" ]; then
          sudo chown -R "$LOGNAME:admin" /usr/local
        fi
      else
        sudo mkdir "$HOMEBREW_PREFIX"
        sudo chflags norestricted "$HOMEBREW_PREFIX"
        sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
      fi

      sudo -v
      bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    else

      echo ""
      echo " ⏭  Homebrew is already installed! 👍"
      echo ""

    fi
    ;;
esac

if command -v brew >/dev/null 2>&1 ; then

  # Tap Brewfile
  if ! brew tap | grep -q "homebrew/bundle" ; then
    echo ""
    echo "  ✅ Running Homebrew bundle script"
    echo ""
    brew tap homebrew/bundle
  fi

  # Install from Brewfile
  cd "$(dirname "$0")"
  brew bundle

fi

exit 0
