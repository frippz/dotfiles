# Check if HOMEBREW_PREFIX is set
if [[ -z "${HOMEBREW_PREFIX}" ]]; then
  PREFIX="/usr/local"
else
  PREFIX="${HOMEBREW_PREFIX}"
fi

if [ -f $PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
