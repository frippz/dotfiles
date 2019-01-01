#!/usr/bin/env bash
#
# Setup rbenv and install some nice gems globally

set -e

# Skip rdoc install
export RUBY_CONFIGURE_OPTS=--disable-install-doc

# Version to install with rbenv
RUBY_VERSION="2.4.5"

# Gems to install
GEMS=(
  "bundler"
  "neovim"
  "tmuxinator"
)

echo ""
echo "  ✔ Running Ruby install script"
echo ""

if ! command -v rbenv >/dev/null 2>&1 && [ ! -d $HOME/.rbenv ]; then
  echo ""
  echo "  ✔ Installing rbenv..."
  echo ""
  git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
  cd $HOME/.rbenv && src/configure && make -C src
  echo ""
  echo "  ✔ Installing ruby-build..."
  echo ""
  git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  echo ""
  echo "  ✔ Installing rbenv-gemset..."
  echo ""
  git clone git://github.com/jf/rbenv-gemset.git $HOME/.rbenv/plugins/rbenv-gemset
  echo ""
  echo "  ✔ Installing rbenv-bundler"
  echo ""
  git clone https://github.com/carsomyr/rbenv-bundler.git $HOME/.rbenv/plugins/bundler
  echo ""
  echo "  ✔ Installing rbenv-bundle-exec"
  echo ""
  git clone https://github.com/maljub01/rbenv-bundle-exec.git $HOME/.rbenv/plugins/rbenv-bundle-exec
  echo ""
  echo "  ✔ Reloading environment"
  echo ""
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

# Check for rbenv before attempting to install gems
if command -v rbenv >/dev/null 2>&1 ; then
  # Check if our selected version of Ruby is installed
  if ! [[ $(rbenv global) == ${RUBY_VERSION} ]] ; then
    echo "  ✔ Installing Ruby for you."
    rbenv install ${RUBY_VERSION}
    rbenv global ${RUBY_VERSION}
  fi
  echo "  ✔ Updating your environment. (gem update --system)"
  eval "$(rbenv init -)"
  gem update --system
  echo ""
  echo "  ✔ Checking for gems to install."
  echo ""
  for GEM in ${GEMS[@]} ; do
    if [[ "$(gem list ${GEM} -i)" == "false" ]] ; then
      gem install $GEM
    fi
  done
fi
