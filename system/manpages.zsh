if command -v nvim > /dev/null; then
    export MANPAGER='nvim +Man!'
else
    export MANPAGER='less'
fi
