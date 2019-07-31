# dotfiles
My macOS environment, profiles, setup, and various dotfiles

## Getting Started

This repository could be installed by running [`install.sh`](tools/install.sh) using either `curl` or `wget`.

### via curl

```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/zakharykaplan/dotfiles/master/tools/install.sh)"
```

### via wget

```shell
bash -c "$(wget -O-  https://raw.githubusercontent.com/zakharykaplan/dotfiles/master/tools/install.sh)"
```

## Manual Installation

Start by cloning this repository to your home directory:

```shell
git clone https://github.com/zakharykaplan/dotfiles.git ~/.dotfiles
```

### Dependencies

Some features of this repository have dependencies as listed in the [`Brewfile`](tools/Brewfile). Before installing, ensure `Homebrew` and `zsh` are installed.

**Homebrew**:

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

For more information on installation, see [website](https://brew.sh).

### Dotfiles

To set up a file for use, create a symbolic link to it with `ln -s` to the target directory. This will allow future updates to be easily installed with `git pull`.

The following files should be installed to your home directory:

* .aliases
* .bash_profile
* .exports
* .functions
* .ignore
* .tmux.conf
* .vimrc
* .zprofile

The following files must be installed to a specific directory:

* **autopair.vim** can be installed with a symbolic link to `~/.vim/plugin`:
    ```shell
    ln -s ~/.dotfiles/autopair.vim ~/.vim/plugin
    ```
* **jellybeans.tmux** can be installed with a symbolic link to `~/.tmux/themes`:
    ```shell
    ln -s ~/.dotfiles/jellybeans.tmux ~/.tmux/themes
    ```
* **redefined.zsh-theme** can be installed with a symbolic link to `~/.oh-my-zsh/custom/themes`, then activated by adding `ZSH_THEME="redefined"` to `~/.zshrc`:
    ```shell
    ln -s ~/.dotfiles/redefined.zsh-theme ~/.oh-my-zsh/custom/themes
    ```

## Uninstallation

To uninstall, run the [`uninstall.sh`](tools/uninstall.sh) script with:

```shell
~/.dotfiles/tools/uninstall.sh
```
