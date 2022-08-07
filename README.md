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

This repository could be installed by running [`install.sh`](tools/install.sh) using either `curl` or `wget`.

### via curl

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/zakharykaplan/dotfiles/master/tools/install.sh)"
```

### via wget

```sh
bash -c "$(wget -O -  https://raw.githubusercontent.com/zakharykaplan/dotfiles/master/tools/install.sh)"
```

## Manual Installation

Start by cloning this repository to your home directory:

```sh
git clone https://github.com/zakharykaplan/dotfiles.git ~/.dotfiles
```

### Dependencies

Some features of this repository have dependencies as listed in the [`Brewfile`](tools/Brewfile). Before installing, ensure `Homebrew` and `zsh` are installed.

**Homebrew**:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

For more information on installation, see [website](https://brew.sh).

### Dotfiles

The dotfiles are installed through symlinks to various directories. To use my configuration, setup  directories and link all dotfiles using the [`Makefile`](Makefile):

```sh
make --directory=~/.dotfiles
```

## Uninstallation

To unlink all dotfiles, use the [`Makefile`](Makefile):

```sh
make --directory=~/.dotfiles uninstall
```
