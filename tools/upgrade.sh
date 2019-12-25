#!/bin/bash
#
#  upgrade.sh
#  Upgrade script.
#
#  Created by Zakhary Kaplan on 2019-12-10.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# -- Upgrade programs --
# Dotfiles
upgrade_dotfiles() {
    ( # Run in subshell
        cd ~/.dotfiles
        [[ -z $(git status -s) ]] || { git stash push --all && REPO_IS_DIRTY=1; }
        git pull --rebase
        [[ $REPO_IS_DIRTY ]] && git stash pop
    )
}

# Homebrew
upgrade_homebrew() {
    if [ $(command -v brew) ]; then
        echo "Updating Homebrew..."
        brew upgrade && brew upgrade && brew cleanup
    fi
}

# Oh My Zsh
upgrade_oh_my_zsh() {
    if [ -d ~/.oh-my-zsh ]; then
        echo "Updating Oh My Zsh..."
        env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
    fi
}


# -- Run script --
main() {
    echo "Starting upgrade..."

    # Upgrade programs
    upgrade_dotfiles
    [ "$1" = "--all" ] && upgrade_homebrew
    [ "$1" = "--all" ] && upgrade_oh_my_zsh

    # Run installer
    ~/.dotfiles/tools/install.sh
}

main "$@"
