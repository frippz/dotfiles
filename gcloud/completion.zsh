# Check if HOMEBREW_PREFIX is set
if [[ -z "${HOMEBREW_PREFIX}" ]]; then
  PREFIX="/usr/local"
else
  PREFIX="${HOMEBREW_PREFIX}"
fi

if [ -d "$PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/" ]; then
  source $PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
  source $PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi
