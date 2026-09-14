if command -v brew >/dev/null 2>&1; then
  alias brews='brew list --versions'
  alias bubo='brew update-if-needed && brew outdated --formula'
  alias bubc='brew upgrade --formula && brew cleanup'
  alias bubu='bubo && bubc'
  alias caskup='brew update-if-needed && brew outdated --cask && brew upgrade --cask && brew cleanup'
  alias bi='brew install'
fi
