#!/usr/bin/env zsh

# Show local branches first on tab completion
zstyle ':completion:*:*:git*:*' group-order heads remotes

# Skip showing refs on tab completion
# zstyle ':completion:*:git-checkout:*' ignored-patterns 'HEAD' 'FETCH_HEAD' 'ORIG_HEAD' 'MERGE_HEAD'
zstyle ':completion:*:*:*:*:*' ignored-patterns 'HEAD' 'FETCH_HEAD' 'ORIG_HEAD'
