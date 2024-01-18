# dotfiles

<p align="center">
  <q>
    UNIX is basically a simple operating system, but you have to be a genius to
    understand the simplicity.
  </q>
  &mdash;
  <i>
    Dennis Ritchie
  </i>
</p>

---

My macOS environment, profiles, setup, and various dotfiles

## Getting Started

This repository could be installed using the provided [`install`][install]
script.

### via curl (Mac)

```sh
curl --proto '=https' --tlsv1.2 -sSf https://zakhary.dev/dotfiles/install.sh | sh
```

### Manual Installation (Mac)

Start by cloning this repository to your home directory:

```sh
git clone https://github.com/kaplanz/dotfiles.git ~/.dots
```

Next, you should be able to run the installer locally:

```sh
~/.dots/bin/dots install
```

### Manual Installation (Ubuntu/Debian)

First, ensure you have all dependencies installed:

1. Install [`zsh`][zsh], for example: `sudo apt install zsh`
1. Install [`fdfind`][fdfind] (ensure that you also symlink to `fd`, if applicable)
1. Install [`eza`][eza]
1. Install [`neovim`][neovim] (often the version in `apt` is out of date)
1. Install all other dependencies in the [`Brewfile`][brewfile], for example: `sudo apt install bat coreutils fzf ripgrep stow tmux`

Then clone the repository:

```sh
git clone https://github.com/kaplanz/dotfiles.git ~/.dots
```

Before you run the installation script, set the `DOTS` env:

```sh
export DOTS=~/.dots
```

Now you should be able to run the installer locally, as normal:

```sh
~/.dots/bin/dots install
```

Of course, don't forget to change your default shell to `zsh`:

```sh
chsh -s $(which zsh)
```

Log out and log in again, then open a terminal to confirm that `zsh` is now the default.

## Dependencies

Some features of this repository have dependencies as listed in the
[`Brewfile`][brewfile]. Before installing, ensure `brew` and `zsh` are
installed.

### Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

For more information on using `brew`, see its [website][homebrew].

### Symlinks

Dotfiles are installed through symlinks to various home subdirectories. To set
up directories and link all dotfiles, use the [`Makefile`][makefile].

```sh
make --directory=~/.dots
```

## Uninstallation

All managed dotfiles can be uninstalled using the [`Makefile`][makefile] with:

```sh
make --directory=~/.dots uninstall
```

<!-- Reference-style links -->
[brewfile]: ./Brewfile
[homebrew]: https://brew.sh
[install]:  ./script/dots
[makefile]: ./Makefile
[zsh]: https://www.zsh.org/
[fdfind]: https://github.com/sharkdp/fd
[eza]: https://github.com/eza-community/eza
[neovim]: https://github.com/neovim/neovim
