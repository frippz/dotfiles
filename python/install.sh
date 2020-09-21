#!/usr/bin/env bash
#
# Install pip packages

PIPS=(
  "pynvim"
)

echo ""
echo "  ✔ Running pip install script"
echo ""

# Check for Python 3 before attempting to install packages
if command -v python3 >/dev/null 2>&1 ; then
  echo ""
  echo "   ✔ Upgrading pip"
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
  echo "  ✘ python not found. You may need to install it first."
  echo ""
fi
