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

## Getting Started

This repository could be installed using the provided [`install`][install]
script.

### via curl

```sh
curl --proto '=https' --tlsv1.2 -sSf https://zakhary.dev/dotfiles/install.sh | sh
```

## Manual Installation

Start by cloning this repository to your home directory:

```sh
git clone https://github.com/kaplanz/dotfiles.git ~/.dotfiles
```

### Dependencies

Some features of this repository have dependencies as listed in the
[`Brewfile`][brewfile]. Before installing, ensure `brew` and `zsh` are
installed.

**Homebrew**:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

For more information on installation, see [website][homebrew].

### Dotfiles

The dotfiles are installed through symlinks to various directories. To set up
directories and link all dotfiles using the [`Makefile`][makefile]:

```sh
make --directory=~/.dotfiles
```

## Uninstallation

All managed dotfiles can be uninstalled using the [`Makefile`][makefile] with:

```sh
make --directory=~/.dotfiles uninstall
```

<!-- Reference-style links -->
[brewfile]: ./Brewfile
[homebrew]: https://brew.sh
[install]:  ./script/dots
[makefile]: ./Makefile
