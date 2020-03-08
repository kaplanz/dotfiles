#!/bin/bash
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
        [[ -z "$(git status -s)" ]] || { git stash push --all && REPO_IS_DIRTY=1; }
        git pull --rebase
        [[ "$REPO_IS_DIRTY" ]] && git stash pop
    )
}

# Homebrew
upgrade_homebrew() {
    if [ "$(command -v brew)" ]; then
        brew upgrade && brew upgrade && brew cleanup
    fi
}

# Oh My Zsh
upgrade_oh_my_zsh() {
    if [ -d ~/.oh-my-zsh ]; then
        env ZSH="$ZSH" sh "$ZSH/tools/upgrade.sh"
    fi
}

# Run script
main() {
    # Upgrade programs
    upgrade_dotfiles_repo
    [ "$1" = "--all" ] && upgrade_homebrew
    [ "$1" = "--all" ] && upgrade_oh_my_zsh

    # Run Makefile
    make --directory="$DOTFILES"

    # Restart shell
    exec zsh -l
}

main "$@"
