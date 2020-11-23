#!/bin/sh
#
#  upgrade.sh
#  Upgrade script.
#
#  Created by Zakhary Kaplan on 2019-12-10.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

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
    # Upgrade programs
    upgrade_dotfiles_repo
    [ "$1" = '--all' ] && {
        upgrade_homebrew
        upgrade_oh_my_zsh
    }

    # Run Makefile
    make --directory="$DOTFILES" install
}

main "$@"
