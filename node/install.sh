#!/usr/bin/env bash
#

# Versions of Node to install
NODE_VERSIONS=(
  "4.8.4"
  "6.11.1"
  "7.10.1"
)
# Packages to install globally with npm
PACKAGES=(
  "autoprefixer"
  "bower"
  "csscomb"
  "eslint"
  "grunt"
  "gulp"
  "htmlhint"
  "http-server"
  "live-server"
  "localtunnel"
  "nodemon"
  "nodemon"
  "npm-check-updates"
  "stylelint"
  "svgo"
)

set -e

# Check for nodenv and install if it’s not installed
if [ ! -d $HOME/.nodenv/bin ] ; then
  echo ""
  echo "  √ nodenv not found. Installing now..."
  echo ""
  git clone https://github.com/nodenv/nodenv.git $HOME/.nodenv
  echo ""
  echo "  √ Reloading environment"
  echo ""
  export PATH=$HOME/.nodenv/bin:$PATH
  eval "$(nodenv init -)"
  echo ""
  echo "  √ Installing node-build plugin..."
  echo ""
  git clone https://github.com/nodenv/node-build.git $HOME/.nodenv/plugins/node-build
  echo ""
  echo "  √ Installing nodenv-update plugin..."
  echo ""
  git clone https://github.com/nodenv/nodenv-update.git $HOME/.nodenv/plugins/nodenv-update
  echo ""
  echo "  √ Attempting to compile dynamic extensions..."
  echo ""
  set +e
  cd $HOME/.nodenv && src/configure && make -C src
  set -e
else
  echo ""
  echo "  √ Looks like nodenv is already installed. Awesome!"
  echo ""
  echo ""
  echo "  √ Installing versions of Node"
  echo ""
  for NODE_VERSION in ${NODE_VERSIONS[@]} ; do
    nodenv install -s ${NODE_VERSION}
  done
fi

# Cache list of already installed global packages
if command -v npm >/dev/null 2>&1 ; then
  INSTALLED_PACKAGES=( $(find `npm root -g` -type d -maxdepth 1 -not -path '*/\.*' -print0 | while IFS= read -r -d '' dirname; do echo ${dirname##*/}; done) )
fi

echo "  √ Running Node install script"
echo ""

# Check for npm if we’re on OS X
if command -v npm >/dev/null 2>&1 ; then
  echo "  √ Looks like npm is installed. Checking for packages to install."
  # Install packages globally
  for PACKAGE in ${PACKAGES[@]} ; do
    if ! echo ${INSTALLED_PACKAGES[@]} | grep -q "${PACKAGE}" ; then
      npm install -g $PACKAGE
    fi
  done
else
  echo "  ✗ npm is not installed. Skipping..."
fi
