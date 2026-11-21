#!/usr/bin/env zsh

# Show local branches first on tab completion
zstyle ':completion:*:*:git*:*' group-order heads remotes

# Skip showing special refs on git tab completion
zstyle ':completion:*:*:git*:*' ignored-patterns 'HEAD' 'FETCH_HEAD' 'ORIG_HEAD' 'MERGE_HEAD'
