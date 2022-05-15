#!/usr/bin/env bash
# File:        upgrade.sh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     10 Dec 2019
# SPDX-License-Identifier: MIT

main() {
    # Unstow all dotfiles before stowing
    make --directory="$DOTFILES" unstow

    # Upgrade programs
    dots-upgrade
    [ "$1" = '--all' ] && {
        brew-upgrade
        omz-upgrade
    }

    # Continue installation in Makefile
    make --directory="$DOTFILES" install
}

# Upgrade dotfiles repo
dots-upgrade() {
    ( # Run in subshell
        cd "$DOTFILES"
        [ -n "$(git status -s)" ] && {
            git stash push --all && REPO_IS_DIRTY=1
        }
        git pull --rebase
        [ -n "$REPO_IS_DIRTY" ] && git stash pop
    )
}

# Homebrew
brew-upgrade() {
    test "$(command -v brew)" && {
        brew update && brew upgrade && brew cleanup
    }
}

# Oh My Zsh
omz-upgrade() {
    [ -d "$ZSH" ] && {
        env ZSH="$ZSH" sh "$ZSH/tools/upgrade.sh"
    }
}

main "$@"
