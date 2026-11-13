# Azure CLI

Azure CLI (`az`) with zsh completion, plus per-project logins scoped with [direnv](https://direnv.net).

macOS only.

## What the dotfiles provide

| Piece | Where | Notes |
| --- | --- | --- |
| `az` | `cask "azure-cli"` in `homebrew/Brewfile` | Distributed as a cask, not a formula |
| `direnv` | `brew "direnv"` in `homebrew/Brewfile` | |
| Completion | Shipped by the cask (`_az` in Homebrew's `site-functions`) | Picked up by `compinit`; nothing to configure |
| direnv hook | `zsh/zshrc` | Runs after PATH and prompt setup |
| Telemetry off | `azure/azure.zsh` | `AZURE_CORE_COLLECT_TELEMETRY=false` |
| `.envrc` ignored | `git/gitignore` (global) | Safety net so `.envrc` files are never committed |

## New machine

1. Run the regular install (see the root `README.md`). `./install --only shell` installs everything in the Brewfile, including `azure-cli` and `direnv`.
2. Open a new shell and check:

   ```zsh
   az version
   direnv status
   ```

   `az <Tab>` should complete.

At this point `az` uses the default config dir, `~/.azure`, for every folder.

## Per-project logins

By default `az` keeps a single login and default subscription in `~/.azure`. If you work across several tenants or clients, give each project its own config dir instead. `az` reads `AZURE_CONFIG_DIR`, and direnv sets it whenever you're inside the project.

1. In the project root, create `.envrc`:

   ```zsh
   export AZURE_CONFIG_DIR="$HOME/.azure-<project>"
   ```

2. Make sure the project ignores `.envrc` too, since the global gitignore doesn't protect other contributors:

   ```zsh
   git check-ignore .envrc
   ```

   If this prints nothing, add `.envrc` to the project's `.gitignore`.

3. Allow it once. direnv refuses to load an `.envrc` until you do, and asks again after every edit:

   ```zsh
   direnv allow .
   ```

4. Log in from inside the project:

   ```zsh
   az login --tenant <tenant-id>
   az account set --subscription <subscription-id-or-name>
   ```

5. Confirm:

   ```zsh
   echo $AZURE_CONFIG_DIR    # ~/.azure-<project> inside, empty outside
   az account show
   ```

The variable applies to the whole folder tree, including subfolders and git worktrees inside the project. It's removed as soon as you `cd` out.

The config dir lives in `$HOME`, outside the repo, so login tokens never end up in git.

### Clearing an old global login

If you logged in before setting this up, the old login is still in `~/.azure`. Run this from outside any project:

```zsh
az logout
```

## Other useful setup

Defaults are stored in the active config dir, so set them per project:

```zsh
az config set defaults.location=<region> core.output=table
```

Extensions are also installed per config dir:

```zsh
az extension add --name <extension>
```

For non-interactive use (scripts, CI), use a service principal. Keep its credentials in `~/.localrc` or the project's `.envrc`, never in a tracked file:

```zsh
az login --service-principal \
  --username "$AZURE_CLIENT_ID" \
  --password "$AZURE_CLIENT_SECRET" \
  --tenant "$AZURE_TENANT_ID"
```

## Caveats

- **Non-interactive shells don't load the direnv hook.** Editors and agent tools that run commands in a plain shell won't see the scoped `AZURE_CONFIG_DIR`. Run the command through direnv instead:

  ```zsh
  direnv exec . az account show
  ```

- **Each config dir has its own login.** A new project, or a new machine, means a new `az login`.
