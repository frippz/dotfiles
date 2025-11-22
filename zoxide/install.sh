#!/bin/sh
#
# Install zoxide on Linux systems

case "$OSTYPE" in
  *linux*)
    if ! command -v zoxide >/dev/null 2>&1 ; then

      echo ""
      echo "  ✅ Installing zoxide"
      echo ""

      curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

    else

      echo ""
      echo " ⏭  zoxide is already installed! 👍"
      echo ""

    fi
    ;;
  *)
    echo ""
    echo " ⏭  Skipping zoxide installation (Linux only)"
    echo ""
    ;;
esac

exit 0
