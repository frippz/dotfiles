# Load machine-private Claude Code settings (e.g. autoMode) kept out of this public repo
if [[ -f ~/.claude/settings.private.json ]]; then
  claude() { command claude --settings ~/.claude/settings.private.json "$@" }
fi
