#!/bin/bash
#
#  update.sh
#  Update script.
#
#  Created by Zakhary Kaplan on 2019-12-10.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# -- Update programs --
# Dotfiles
update_dotfiles() {
    ( # Run in subshell
        cd ~/.dotfiles
        [[ -z $(git status -s) ]] || { git stash push --all && REPO_IS_DIRTY=1; }
        git pull --rebase
        [[ $REPO_IS_DIRTY ]] && git stash pop
    )
}

# Homebrew
update_homebrew() {
    if [ $(command -v brew) ]; then
        echo "Updating Homebrew..."
        brew update && brew upgrade && brew cleanup
    fi
}

# Oh My Zsh
update_oh_my_zsh() {
    if [ -d ~/.oh-my-zsh ]; then
        echo "Updating Oh My Zsh..."
        env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
    fi
}


# -- Run script --
main() {
    echo "Starting update..."

    # Update programs
    update_dotfiles
    [ "$1" = "--all" ] && update_homebrew
    [ "$1" = "--all" ] && update_oh_my_zsh

    # Run installer
    ~/.dotfiles/tools/install.sh
}

main "$@"
