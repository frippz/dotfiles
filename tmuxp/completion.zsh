# ZSH completion for tmuxp

_tmuxp_sessions() {
  local config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/tmuxp"
  local -a sessions
  sessions=(${config_dir}/*.{yaml,json}(N:t:r))
  compadd -a sessions
}

_tmuxp() {
  local -a subcommands
  subcommands=(
    'load:Load a tmux session from a config'
    'ls:List available configs'
    'edit:Edit a config in \$EDITOR'
    'freeze:Snapshot the current session to a config'
    'convert:Convert a config between YAML and JSON'
    'import:Import a teamocil or tmuxinator config'
    'shell:Open a libtmux Python shell'
    'debug-info:Print debug information'
  )

  _arguments -C \
    '(-h --help)'{-h,--help}'[Show help]' \
    '--version[Show version]' \
    '--log-level[Set log level]:level:(debug info warning error critical)' \
    '--color[Color output]:mode:(auto always never)' \
    '1:subcommand:->subcmd' \
    '*::args:->args'

  case $state in
    subcmd)
      _describe 'subcommand' subcommands
      ;;
    args)
      case $words[1] in
        load|edit)
          _tmuxp_sessions
          ;;
      esac
      ;;
  esac
}

compdef _tmuxp tmuxp
