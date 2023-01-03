# dotfiles – frippz style

I LOVE MY DOTFILES!!!

## Usage

Make sure you're running `zsh` first

```zsh
$ chsh -s $(which zsh)
```

Initialize submodules

```zsh
$ git submodule init
$ git submodule update
```

Run the [dotbot](https://github.com/anishathalye/dotbot) install script

```zsh
$ ./install --except shell
```

Open an new tab and run the install script again with only the shell directive

```zsh
$ ./install --only shell
```

All done! Unless something went wrong, then go ahead and curse… 😖
