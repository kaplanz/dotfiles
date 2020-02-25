#!/bin/bash
#
#  install.sh
#  Installer script.
#
#  Created by Zakhary Kaplan on 2019-06-05.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# Clone dotfiles repository
clone_dotfiles_repo() {
    if [ ! -d ~/.dotfiles ]; then
        git clone https://github.com/zakharykaplan/dotfiles.git ~/.dotfiles
    fi
}

# Install Homebrew
install_homebrew() {
    if [ ! $(command -v brew) ] && [ $(uname) == "Darwin" ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

# Run script
main() {
    # Install programs
    clone_dotfiles_repo
    install_homebrew

    # Run Makefile
    make --directory=~/.dotfiles install

    # Restart shell
    exec zsh -l
}

main "$@"
