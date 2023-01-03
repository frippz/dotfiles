export HOMEBREW_BUNDLE_NO_LOCK=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_BUNDLE_FILE=$HOME/.dotfiles/homebrew/Brewfile

# Homebrew completion
if command -v brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi
