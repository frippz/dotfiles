#!/usr/bin/env bash
#
# Install Ruby via rbenv and gems

VERSION="3.1.2"

PLUGINS=(
  "git@github.com:nabeo/rbenv-gem-migrate.git"
)

GEMS=(
  "bundler"
  "neovim"
  "tmuxinator"
  "solargraph"
)

# if command -v rbenv >/dev/null 2>&1 ; then

  echo ""
  echo " ✅ Install Ruby using rbenv and set ${VERSION} as global"
  echo ""

  rbenv install ${VERSION} --skip-existing
  rbenv global ${VERSION}
  rbenv rehash

# fi

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
# if command -v gem >/dev/null 2>&1 ; then

  echo ""
  echo " ✅ Installing gems"
  echo ""

  for GEM in ${GEMS[@]} ; do
    if ! gem list | grep -q "$GEM"; then
      gem install $GEM
    else
      echo "    ℹ️  $GEM already installed."
      echo ""
    fi
  done

# else

  # echo ""
  # echo " ⛔️ gem command not found."
  # echo ""

# fi
