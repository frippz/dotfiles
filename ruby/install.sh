#!/usr/bin/env bash
#
# Install Ruby via rbenv and gems

VERSION="3.2.2"

PLUGINS=(
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
    echo ""
    echo " ✅ Installing rbenv using git"
    echo ""

    git clone https://github.com/rbenv/rbenv.git $RBENV_HOME
    PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init -)"

  else
    echo ""
    echo " ⚠️  $RBENV_HOME is already present. Skipping install..."
    echo ""
  fi
else
  echo "  ⛔️ git not found. Aborting..."
fi

if command -v rbenv > /dev/null 2>&1; then

  echo ""
  echo " ✅ Install Ruby using rbenv and set ${VERSION} as global"
  echo ""

  rbenv install ${VERSION} --skip-existing
  rbenv global ${VERSION}
  rbenv rehash

fi

# Install rbenv plugins
if [ -d $HOME/.rbenv ]; then
  echo ""
  echo " ✅ Installing rbenv plugins"
  echo ""
  for PLUGIN in ${PLUGINS[@]}; do
    PLUGIN_NAME=$(echo $PLUGIN | sed -E 's/.*\/([^/]+)\.git$/\1/')
    if [ ! -d "$(rbenv root)/plugins/$PLUGIN_NAME" ]; then
      git clone $PLUGIN $(rbenv root)/plugins/$PLUGIN_NAME
    else
      echo "    ℹ️  $PLUGIN_NAME is already installed"
      echo ""
    fi
  done
fi

# Check for gem before attempting to install packages
if command -v gem > /dev/null 2>&1; then

  echo ""
  echo " ✅ Installing gems"
  echo ""

  for GEM in ${GEMS[@]}; do
    if ! gem list | grep -q "$GEM"; then
      gem install $GEM
    else
      echo "    ℹ️  $GEM already installed. Checking for update instead"
      echo ""
      gem update $GEM
    fi
  done

else

  echo ""
  echo " ⛔️ gem command not found."
  echo ""

fi
