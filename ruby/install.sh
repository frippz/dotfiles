#!/usr/bin/env zsh

source $HOME/.dotfiles/zsh/msg.zsh

# Install Ruby via rbenv and gems

VERSION="3.2.2"

PLUGINS=(
  "https://github.com/rkh/rbenv-update.git"
  "https://github.com/nabeo/rbenv-gem-migrate.git"
)

GEMS=(
  "bundler"
  "neovim"
  "tmuxinator"
  "solargraph"
)

RBENV_HOME="$HOME/.rbenv"

# Install rbenv
if command -v git > /dev/null 2>&1; then
  if [ ! -d "$RBENV_HOME" ]; then
    msg_info "Installing rbenv using git"

    git clone https://github.com/rbenv/rbenv.git $RBENV_HOME
    PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

  else
    msg_done "$RBENV_HOME is already present. Skipping install..."
  fi
else
  msg_fail "git not found. Aborting..."
  exit 1
fi

if command -v rbenv > /dev/null 2>&1; then

  msg_info "Installing Ruby using rbenv and set ${VERSION} as global"

  rbenv update
  rbenv install ${VERSION} --skip-existing
  rbenv global ${VERSION}
  rbenv rehash

fi

# Install rbenv plugins
if [ -d $RBENV_HOME ]; then
  msg_info "Installing rbenv plugins"
  for PLUGIN in ${PLUGINS[@]}; do
    PLUGIN_NAME=$(echo $PLUGIN | sed -E 's/.*\/([^/]+)\.git$/\1/')
    if [ ! -d "$(rbenv root)/plugins/$PLUGIN_NAME" ]; then
      msg_info "Installing $PLUGIN"
      git clone $PLUGIN $(rbenv root)/plugins/$PLUGIN_NAME
    else
      msg_done "$PLUGIN_NAME is already installed."
    fi
  done
fi

# Check for gem before attempting to install packages
if command -v gem > /dev/null 2>&1; then

  msg_info "Installing gems"

  for GEM in ${GEMS[@]}; do
    if ! gem list | grep -q "$GEM"; then
      msg_info "Installing $GEM"
      gem install $GEM
    else
      msg_done "$GEM already installed. Checking for update instead."
      gem update $GEM
    fi
  done

else

  msg_fail "gem command not found."
  exit 1

fi
