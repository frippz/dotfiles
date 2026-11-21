# Drop duplicate entries when files prepend to PATH (or zshrc is re-sourced)
typeset -U path

# Homebrew's dirs come from `brew shellenv` (homebrew/path.zsh) and system dirs
# from the default PATH, so only add our own here
export PATH="$HOME/.scripts:$HOME/.local/bin:$PATH"
