#!/usr/bin/env bash
#
# Setup required taps and install Homebrew packages using Brewfile

case "$OSTYPE" in
  *darwin*)
    if ! command -v brew >/dev/null 2>&1 ; then

      echo ""
      echo " ✔ Installing Homebrew"
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

      curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    fi
    ;;
esac

if command -v brew >/dev/null 2>&1 ; then

  # Tap Brewfile
  if ! brew tap | grep -q "homebrew/bundle" ; then
    echo ""
    echo "  ✔ Running Homebrew bundle script"
    echo ""
    brew tap homebrew/bundle
  fi

  # Install from Brewfile
  brew bundle

fi

exit 0
