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

## About

Contained within this repository is years' worth of configuration files for my
personal setup on macOS (and Linux). While these, by nature, are ever changing
to suit my command-line needs, they are nevertheless packaged in such a way that
they can be enjoyed by downstream users.

> [!IMPORTANT]
>
> **I make no promises or guarantees about the stability of this
> configuration.** It is entirely possible (even likely) that the tools I use
> will slowly change as my needs evolve. That being said, I do try to avoid
> breaking changes as far as the installer is concerned. Once installed, your
> local clone of my dotfiles should be indefinitely upgradable as specified by
> the [instructions below](#installation).

## Getting Started

> [!CAUTION]
>
> During installation, I recommend using my dotfiles manager script, `dots`, to
> simplify the setup process. It should go without saying that **you should make
> sure you trust any code before you run it**. In the spirit of openness, I
> encourage you to read through [the script][dots] beforehand to ensure it
> doesn't do anything you're not comfortable with.

### Dependencies

For the scripts to properly run, it's expected that you have a reasonable
POSIX-like shell linked at `/bin/sh` (`bash` and `dash` should both be fine).
Almost all Unix-like operating systems should already have this set up for you.

The following programs are required to perform automated installation:

- `curl`: Request files over the Internet.
- `git`:  Clone this (and other) repositories containing configuration files or
          setup tools.
- `make`: Smartly (re)install only updated parts of the configuration as-needed.
- `stow`: Manage symbolic links between your local clone of this repository and
          their expected paths under `$HOME`.

> [!TIP]
>
> If you are on macOS, it is highly recommended you install [Homebrew][brew] to
> manage [dependencies][brewfile] for you (see [here](#homebrew) for more
> details). If you have done so, then the above dependencies will be
> automatically installed during setup.

## Installation

After installing the above dependencies, you have two main options for
installing: [Quickstart](#quickstart) and [Manual](#manual).

### Quickstart

So, you're looking to just get this over with already? Your troubles end here!
Simply paste this command to download the installer and get on your merry way:

```sh
curl --proto '=https' --tlsv1.2 -sSf https://zakhary.dev/dotfiles/install.sh | sh
```

Assuming everything worked as expected, you should receive a message that
installation was completed and can move on to [next steps](#usage).

### Manual

You're the type that prefers to do things yourself. I totally get it. Let's walk
through each part of what we're going to be doing here.

#### Clone

Start by cloning this repository to your home directory:

```sh
git clone https://github.com/kaplanz/dotfiles.git ~/.dots
```

> [!NOTE]
>
> You may have noticed that we're explicitly cloning into `$HOME/.dots`. This is
> the preferred location for the repository. Although not required, the
> [installer][dots] (and [Makefile]) both expect to find it at this path. If you
> choose to run the configuration out of another location, it is required that
> you set the environment variable `DOTS` to the path before running any of
> those scripts.

#### [Installer][dots]

From this point on, if you've taken a look at your local clone and are satisfied
that my scripts don't do anything suspicious, you can always choose to run the
installer manually to get the rest of setup over with.

```sh
~/.dots/bin/dots install
```

> [!TIP]
>
> If you're getting an error about `libdots.sh` not being found, run `export
> DOTS=~/.dots` and try again.

#### [Makefile]

The bulk of the actual installation is handled by `make`. This includes
symlinking the actual dotfiles to their respective locations (using a tool
called `stow`; basically a Perl script), as well as downloading external
configuration for `tmux` and `zsh`.

Running `make` from within your repository clone will perform these steps,
usually done by the installer.

## Usage

Once properly set up, change your shell with `chsh -s zsh` and enjoy your shiny
new configuration. (You may need to restart your shell for good measure.)
Assuming everything works at this point, the real fun begins.

### Tools

> [!NOTE]
>
> If you performed manual installation, or do not have [Homebrew](#homebrew)
> installed (such as on Linux, where I do not recommended it), you may need to
> install some of the tools described below using your package manager.
>
> On Debian-based Linux distributions, you can do this with `apt`, e.g.:
>
> ```sh
> sudo apt install bat coreutils eza fdfind fzf neovim ripgrep stow tmux zsh
> ```

#### [Zsh]

Your prompt should now look something like `~ »`. By default, `zsh` will now use
vi mode key bindings. Furthermore, using a great tool called [fzf], the
following keys have been supercharged:

- `<C-R>`: Easily find useful previous commands from your history.
- `<C-T>`: Insert a path to any file or directory underneath your `$PWD`.
- `<M-C>`: Quickly search for a child directory to change to.

> [!NOTE]
>
> Some of these fzf bindings use a tool called `fd` (or `fdfind`), which must be
> separately installed (and in your path as `fd`) for these mappings to work
> properly.

> [!TIP]
>
> Full configuration is available at `~/.config/zsh`.

#### [tmux]

While minimal, `tmux` has also been configured with a slightly cleaner look and
more intuitive bindings (to me). For a detailed look at the bindings and
configuration, see [tmux.conf].

> [!TIP]
>
> Full configuration is available at `~/.config/tmux`.

#### [Neovim]

My Neovim configuration should have also been installed. If you plan to use it,
I highly recommend you check out its [README][nvim] for more info.

> [!TIP]
>
> Full configuration is available at `~/.config/nvim`.

## Customization

It is often the case that you want to add lines of configuration to your shell.
When using my dotfiles, it is recommended to place any such configuration in a
file at `~/.config/zsh/.zlogin`.

> [!WARNING]
>
> The usual files locations under `$HOME` (such as `~/.zlogin`) are no longer
> read, as shell configuration was moved to `~/.config/zsh`.

## Troubleshooting

If you encounter any problems, please feel free to reach out to me directly, or
better yet, [raise an issue][issue].

## Uninstallation

All managed dotfiles can be unlinked using the [Makefile]:

```sh
make -C ~/.dots uninstall
```

Afterwards, to fully remove this repository, simply delete it:

```sh
rm -rf ~/.dots
```

## Extra

### Homebrew

Homebrew is the unofficial "missing package manager for macOS." It is a
fantastic alternative to manually installing programs on an Apple system,
instead working much like any other traditional package manager (such as `apt`,
`pacman`, or `xbps`).

You can easily install it using the following command, shamelessly copied from
the project's [homepage][brew].

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

<!-- Reference-style links -->
[brew]:      https://brew.sh
[brewfile]:  ./Brewfile
[dots]:      ./script/dots
[eza]:       https://github.com/eza-community/eza
[fdfind]:    https://github.com/sharkdp/fd
[fzf]:       https://github.com/junegunn/fzf
[issue]:     /../../issues/new/choose
[makefile]:  ./Makefile
[neovim]:    https://neovim.io
[nvim]:      https://git.zakhary.dev/nvim
[tmux.conf]: ./apps/tmux/tmux.conf
[tmux]:      https://github.com/tmux/tmux/wiki
[zsh]:       https://www.zsh.org/
