#!/usr/bin/env bash
#
# Install pip packages

PIPS=(
  "pynvim"
  "tmuxp"
)

echo ""
echo "  ✔ Running pip install script"
echo ""

# Check for Python before attempting to install gems
if command -v python >/dev/null 2>&1 ; then
  echo ""
  echo "   ✔ Upgrading pip"
  echo ""
  case "$OSTYPE" in
    *darwin*)
      pip install --upgrade pip
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
    $PREFIX pip install -U $PIP
  done
else
  echo ""
  echo "  ✘ python not found. You may need to install it first."
  echo ""
fi
