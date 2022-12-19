#!/usr/bin/env bash
#
# Install Python via pyenv and pip packages

VERSION="3.11.1"

PIPS=(
  "pipenv"
  "pynvim"
  "yamllint"
)

# Check for pyenv before attempting to install packages
if command -v pyenv >/dev/null 2>&1 ; then

  echo ""
  echo " ✅ Install Python using pyenv and set ${VERSION} as global"
  echo ""

  pyenv install ${VERSION} --skip-existing
  pyenv global ${VERSION}
  pyenv rehash

fi

# Check for pip before attempting to install packages
if command -v pip >/dev/null 2>&1 ; then

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
  echo "  ⛔️ python not found. You may need to install it first."
  echo ""

fi
