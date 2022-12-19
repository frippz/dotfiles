#!/usr/bin/env bash
#
# Install Ruby via rbenv and gems

VERSION="3.1.3"

GEMS=(
  "bundler"
  "neovim"
  "tmuxinator"
)

if command -v rbenv >/dev/null 2>&1 ; then

  echo ""
  echo " ✅ Install Ruby using rbenv and set ${VERSION} as global"
  echo ""

  rbenv install ${VERSION} --skip-existing
  rbenv global ${VERSION}
  rbenv rehash

fi

# Check for gem before attempting to install packages
if command -v gem >/dev/null 2>&1 ; then

  echo ""
  echo " ✅ Installing gems"
  echo ""

  for GEM in ${GEMS[@]} ; do
    gem install $GEM
  done

else

  echo ""
  echo " ⛔️ gem command not found."
  echo ""

fi
