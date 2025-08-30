# My very own dotfiles

[![Scan for secrets 👀](https://github.com/frippz/dotfiles/actions/workflows/trufflehog.yml/badge.svg)](https://github.com/frippz/dotfiles/actions/workflows/trufflehog.yml)

These dotfiles are made for [Zsh](https://www.zsh.org), so first switch over.

```zsh
chsh -s $(which zsh)
```

Initialize submodules (for dotbot)

```zsh
git submodule update --init --recursive
```

Run the [dotbot](https://github.com/anishathalye/dotbot) install script

```zsh
./install --except shell
```

Refresh your environment or just open an new tab and run the install script again with only the shell directive

```zsh
./install --only shell
```

Done! 👍
