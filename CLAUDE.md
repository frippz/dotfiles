# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal dotfiles for Zsh on macOS (primary) and Linux (secondary), installed with [dotbot](https://github.com/anishathalye/dotbot) (git submodule in `dotbot/`). The repo is public and lives at `~/.dotfiles` (exported as `$ZSH`). There is no build or test suite; CI only runs a TruffleHog secret scan on push/PR.

## Commands

```zsh
git submodule update --init --recursive   # fetch dotbot
./install --except shell                  # symlinks + directories only
./install --only shell                    # run the install scripts (Homebrew, Node globals, bob, Claude Code)
./install                                 # everything
```

`./install` is idempotent (`link.force: true`, and each `install.sh` checks whether its tool already exists), so rerun it after editing `install.conf.yaml`. Changes to `*.zsh` files take effect in a new shell (or `source ~/.zshrc`).

## Architecture

Topic-based layout: each tool gets a directory (`git/`, `homebrew/`, `node/`, `claude/`, …) holding everything related to it. Two mechanisms wire topics into the system:

1. **Symlinks via `install.conf.yaml`.** Config files (`nvim/`, `ghostty/`, `tmux/`, `git/gitconfig`, `claude/settings.json`, `claude/skills/*`, …) are only active if they're linked here. A new config file needs a `link` entry (and a `create` entry if the parent dir under `~/.config` must exist). The `shell` section lists the per-topic `install.sh` scripts that run during install.

2. **Auto-sourcing via `zsh/zshrc`.** Every `**/*.zsh` file in the repo is sourced automatically — no registration needed. Load order is determined by filename/location:
   1. `~/.localrc` (machine-private env vars, outside the repo)
   2. `*/path.zsh`
   3. `system/*.zsh` (env vars like `XDG_*`, base `PATH` in `system/_path.zsh`)
   4. all other `*.zsh` except completions (`aliases.zsh`, `<topic>.zsh`, …)
   5. `compinit`, then `*/completion.zsh`

   Because sourcing is glob-based, any `.zsh` file anywhere in the repo will be loaded. Give files that shouldn't be sourced on every shell start a different extension.

Conventions for install scripts: `#!/usr/bin/env zsh`, `source $HOME/.dotfiles/zsh/msg.zsh` and use `msg_info`/`msg_done`/`msg_warn`/`msg_fail`, guard OS-specific work with `case "$OSTYPE"` (`*darwin*`, `*linux*`), and skip if the tool is already installed. `homebrew/install.sh` is an older POSIX `sh` script that doesn't follow this.

### Notable topics

- **`homebrew/`**: `Brewfile` (formulas), `Brewfile.casks` (GUI apps), `Brewfile.mas` (App Store). Adding/removing a package means editing the right Brewfile. Only `Brewfile` is installed by `./install`; the casks and App Store files are intentionally manual (`brew bundle --file=…`) — don't wire them into the install script.
- **`node/install.sh`**: global packages are a `PACKAGES` array installed with `pnpm -g`.
- **`nvim/`**: Lua config using lazy.nvim. `init.lua` requires the modules in `nvim/lua/`; `plugin.lua` imports every spec in `nvim/lua/plugins/` (one plugin per file, returning a lazy spec). Formatters are configured in `plugins/conform.lua`, LSP servers via `plugins/mason.lua`/`lspconfig.lua`. Theme is Everforest (also used in Ghostty).
- **`claude/`**: `settings.json` and `skills/*` are symlinked into `~/.claude/`. Machine-private settings live in `~/.claude/settings.private.json` (not in the repo); `claude/claude.zsh` wraps `claude` to pass it via `--settings`. Never put private settings in `claude/settings.json`.
- **`scripts/`**: standalone utilities, linked to `~/.scripts` and on `PATH`.
- **`dotbot/`**: upstream submodule — don't edit; bump the submodule instead.

## Conventions

- Commit messages use Conventional Commits with the topic as scope, e.g. `fix(nvim): …`, `chore(homebrew): …`, `feat(claude): …`.
- `.editorconfig`: 2-space indent, LF, final newline (4 spaces for Python).
- Renovate is configured (`renovate.json`) to pin and auto-merge minor/patch updates.
- This repo is public: secrets and machine-specific values go in `~/.localrc` or other untracked files.
