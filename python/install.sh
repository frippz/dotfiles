#!/usr/bin/env bash
#
# Install pip packages

PIPS=(
  "neovim"
)

echo ""
echo "  ✔ Running pip3 install script"
echo ""

# Check for rbenv before attempting to install gems
if command -v python3 >/dev/null 2>&1 ; then
  echo ""
  echo "   ✔ Upgrading pip3"
  echo ""
  case "$OSTYPE" in
    *darwin*)
      pip3 install --upgrade pip
      ;;
    *linux*)
      sudo -H pip3 install --upgrade pip
      ;;
  esac
  echo ""
  echo "   ✔ Installing Python packages"
  echo ""
  for PIP in ${PIPS[@]} ; do
    case "$OSTYPE" in
      *darwin*)
        PREFIX=""
        ;;
      *linux*)
        PREFIX="sudo -H "
        ;;
    esac
    $PREFIX pip3 install -U $PIP
  done
else
  echo ""
  echo "  ✘ python3 not found. You may need to install it first."
  echo ""
fi
