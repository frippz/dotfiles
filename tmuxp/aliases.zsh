if command -v tmuxp >/dev/null 2>&1 ; then
  # Re-purpose mux command from tmuxinator for tmuxp
  alias mux="tmuxp load"
fi
