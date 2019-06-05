# dotfiles
My macOS environment, profiles, setup, and various dotfiles

## Getting Started

Start by cloning this repository to your home directory:

```shell
git clone https://github.com/zakharykaplan/dotfiles.git ~/.dotfiles
```

To set up a file for use, link it using `ln -s` to the target directory. This will allow future updates to be easily installed with `git pull`.

## Manual Installation

### Programs

**Homebrew**:

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

For more information on installation, see [website](https://brew.sh).

**Zsh**:

```shell
brew install zsh
```

**Oh My Zsh**:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

For more information on installation, see [repository](https://github.com/robbyrussell/oh-my-zsh).

### Dotfiles

**.aliases** can be installed with a symbolic link to your home directory:

```shell
ln -s ~/.dotfiles/.aliases ~/
```

**.bash_profile** can be installed with a symbolic link to your home directory:

```shell
ln -s ~/.dotfiles/.bash_profile ~/
```

**.exports** can be installed with a symbolic link to your home directory:

```shell
ln -s ~/.dotfiles/.exports ~/
```

**.functions** can be installed with a symbolic link to your home directory:

```shell
ln -s ~/.dotfiles/.functions ~/
```

**.zprofile** can be installed with a symbolic link to your home directory:

```shell
ln -s ~/.dotfiles/.zprofile ~/
```

**redefined.zsh-theme** can be installed with a symbolic link to `~/.oh-my-zsh/custom/themes`:

```shell
ln -s ~/.dotfiles/redefined.zsh-theme ~/.oh-my-zsh/custom/themes
```

Activate it by adding `ZSH_THEME="redefined"` to `~/.zshrc`
