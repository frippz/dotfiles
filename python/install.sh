#!/usr/bin/env bash
#
# Install Python via pyenv and pip packages

VERSION="3.11.1"

PLUGINS=(
  "https://github.com/pyenv/pyenv-pip-migrate.git"
)

PIPS=(
  "awscli"
  "grc"
  "pipenv"
  "pynvim"
  "yamllint"
  "yt-dlp"
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

# Install pyenv plugins
if [ -d $HOME/.pyenv ]; then
  echo ""
  echo " ✅ Installing pyenv plugins"
  echo ""
  for PLUGIN in ${PLUGINS[@]}; do
    PLUGIN_NAME=$(echo $PLUGIN | sed -E 's/.*\/([^/]+)\.git$/\1/')
    if [ ! -d "$(pyenv root)/plugins/$PLUGIN_NAME" ]; then
      git clone $PLUGIN $(pyenv root)/plugins/$PLUGIN_NAME
    else
      echo "    ℹ️  $PLUGIN_NAME is already installed"
      echo ""
    fi
  done
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
    if ! pip list --format json | grep -q "$PIP"; then
      pip install --user $PIP
    else
      echo "    ℹ️  $PIP already installed."
      echo ""
    fi
  done

else

  echo ""
  echo "  ⛔️ python not found. You may need to install it first."
  echo ""

fi
