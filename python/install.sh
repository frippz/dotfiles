#!/usr/bin/env zsh

source $HOME/.dotfiles/zsh/msg.zsh

# Install Python via pyenv and pip packages

VERSIONS=(
  "3.9.18"
  "3.11.1"
  "3.11.11"
)

GLOBAL_VERSION="3.11.11"

PLUGINS=(
  "https://github.com/pyenv/pyenv-pip-migrate.git"
)

PIPS=(
  "pip-autoremove"
  "awscli"
  "beautysh"
  "grc"
  "pipenv"
  "pynvim"
  "ruff"
  "yamllint"
  "yt-dlp"
)

PYENV_HOME="$HOME/.pyenv"

# Install pyenv
if command -v git > /dev/null 2>&1; then
  if [ ! -d "$PYENV_HOME" ]; then
    msg_info "Installing pyenv using git"

    git clone https://github.com/pyenv/pyenv.git $PYENV_HOME
  else
    msg_done "pyenv is already installed. Skipping..."
  fi
else
  msg_fail "git not found. Aborting..."
  exit 1
fi

# Compile dynamic extensions
if command -v make > /dev/null 2>&1; then
  msg_info "Compiling dynamic extensions for pyenv"
  cd $PYENV_HOME && src/configure && make -C src
fi

# Check for pyenv before attempting to install packages
if command -v pyenv > /dev/null 2>&1; then

  msg_info "Installing Python versions using pyenv and set ${GLOBAL_VERSION} as global"

  for VERSION in ${VERSIONS[@]}; do
    msg_info "Installing $VERSION"
    pyenv install $VERSION --skip-existing
  done

  pyenv global $VERSION
  pyenv rehash

fi

# Install pyenv plugins
if [ -d $PYENV_HOME ]; then
  msg_info "Installing pyenv plugins"
  for PLUGIN in ${PLUGINS[@]}; do
    PLUGIN_NAME=$(echo $PLUGIN | sed -E 's/.*\/([^/]+)\.git$/\1/')
    if [ ! -d "$(pyenv root)/plugins/$PLUGIN_NAME" ]; then
      msg_info "Installing $PLUGIN"
      git clone $PLUGIN $(pyenv root)/plugins/$PLUGIN_NAME
    else
      msg_done "$PLUGIN_NAME is already installed"
    fi
  done
fi

# Check for pip before attempting to install packages
if command -v pip > /dev/null 2>&1; then

  msg_info "Upgrading pip"

  pip install --upgrade pip

  msg_info "Installing Python packages"

  for PIP in ${PIPS[@]}; do
    if ! pip list --format json | grep -q "$PIP"; then
      pip install --user $PIP
    else
      msg_done "$PIP already installed. Checking for upgrades instead."
      pip install --upgrade --user $PIP
      echo ""
    fi
  done

else

  msg_fail "python not found. You may need to install it first."
  exit 1

fi
