# Copilot Instructions for Dotfiles

## Architecture Overview

This is a modular macOS/Linux dotfiles repository using **dotbot** for installation management. The architecture follows a topic-based organization where each directory (`git/`, `zsh/`, `homebrew/`, etc.) contains all related configurations for that tool.

### Key Components

- **dotbot**: Git submodule providing declarative installation via `install.conf.yaml`
- **Topic directories**: Each tool gets its own directory with `.zsh` files for shell integration
- **ZSH modular loading**: `zsh/zshrc` discovers and loads all `*.zsh` files across topics in a specific order

## Critical Workflows

### Installation Process
```bash
# Two-stage install (shell config loaded after other tools)
./install --except shell
./install --only shell
```

### ZSH Loading Order (from `zsh/zshrc`)
1. `*/path.zsh` files first (PATH setup)
2. All other `*.zsh` files except completions
3. `*/completion.zsh` files last (after compinit)

### Adding New Tools
1. Create topic directory: `newtool/`
2. Add shell integration: `newtool/newtool.zsh`
3. Add symlinks to `install.conf.yaml`
4. Add packages to appropriate Brewfile

## Project-Specific Patterns

### File Naming Conventions
- `*.zsh`: Shell configuration loaded automatically by zshrc
- `path.zsh`: PATH modifications (loaded first)
- `completion.zsh`: Tab completions (loaded last)
- `aliases.zsh`: Command aliases
- `install.sh`: Tool-specific installation scripts

### Configuration Strategy
- **Symlinks over copies**: `install.conf.yaml` creates symlinks to keep configs in repo
- **OS-specific logic**: Check `$OSTYPE` in shell files (see `system/aliases.zsh`)
- **Local overrides**: `~/.localrc` for private/machine-specific config

### Homebrew Integration
- `Brewfile`: Core CLI tools
- `Brewfile.casks`: GUI applications  
- `Brewfile.mas`: Mac App Store apps
- `install.sh`: Handles Homebrew installation + bundle install

### Scripts Directory
Personal utility scripts in `scripts/` (symlinked to `~/.scripts`, added to PATH):
- macOS utilities (`purgeDNScache`, `spotlight-reload.sh`)
- Git helpers (`git-cdc`, `git-kill`)
- Media tools (`imgcat`, `optimize-svg.sh`)

## Key Files to Reference

- `zsh/zshrc`: ZSH auto-loading mechanism
- `install.conf.yaml`: Dotbot configuration defining all symlinks
- `system/_path.zsh`: PATH configuration with Homebrew paths
- `system/aliases.zsh`: OS-specific alias patterns
- `homebrew/install.sh`: Conditional Homebrew installation logic

## Integration Points

- **Dotbot submodule**: Update with `git submodule update --init --recursive`
- **Homebrew bundles**: Tool dependencies managed via Brewfiles
- **XDG compliance**: Configs placed in `~/.config/` where supported
- **Cross-platform**: macOS primary, Linux secondary support via OSTYPE checks

When modifying configurations, ensure changes work with the auto-loading ZSH pattern and maintain the topic-based organization for clarity.
