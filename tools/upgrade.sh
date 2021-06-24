#!/usr/bin/env bash
# File:        upgrade.sh
# Author:      Zakhary Kaplan <https://zakharykaplan.ca>
# Created:     10 Dec 2019
# SPDX-License-Identifier: MIT

# Upgrade dotfiles repo
upgrade_dotfiles_repo() {
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
upgrade_homebrew() {
    test "$(command -v brew)" && {
        brew update && brew upgrade && brew cleanup
    }
}

# Oh My Zsh
upgrade_oh_my_zsh() {
    [ -d "$ZSH" ] && {
        env ZSH="$ZSH" sh "$ZSH/tools/upgrade.sh"
    }
}

# Run script
main() {
    # Unstow all dotfiles before stowing
    make --directory="$DOTFILES" unstow

    # Upgrade programs
    upgrade_dotfiles_repo
    [ "$1" = '--all' ] && {
        upgrade_homebrew
        upgrade_oh_my_zsh
    }

    # Continue installation in Makefile
    make --directory="$DOTFILES" install
}

main "$@"
