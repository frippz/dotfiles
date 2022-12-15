#!/usr/bin/env bash
#
# Install pip packages

VERSION="3.11.1"

PIPS=(
  "pynvim"
  "yamllint"
)

echo ""
echo " ✅ Install Python using pyenv and set ${VERSION} as global"
echo ""

CFLAGS='-I$(xcrun --show-sdk-path)/usr/include' pyenv install ${VERSION} --skip-existing
pyenv global ${VERSION}
pyenv rehash

echo ""
echo " ✅ Running pip install script"
echo ""

# Check for Python before attempting to install packages
if command -v python >/dev/null 2>&1 ; then

  echo ""
  echo " ✅ Upgrading pip"
  echo ""

  pip install --upgrade pip

  echo ""
  echo " ✅ Installing Python packages"
  echo ""

  for PIP in ${PIPS[@]} ; do
    pip install --user $PIP
  done

else

  echo ""
  echo "  ✘ python not found. You may need to install it first."
  echo ""

fi
