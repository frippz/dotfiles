if command -v brew >/dev/null 2>&1 ; then
  alias brews='brew list --versions'
  alias bubo='brew update && brew outdated'
  alias bubc='brew upgrade && brew cleanup'
  alias bubu='bubo && bubc'
  alias bi='brew install'
fi
