#!/bin/bash
#
#  install.sh
#  Installer script.
#
#  Created by Zakhary Kaplan on 2019-06-05.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# Check if minimum dependencies are installed
check_dependencies() {
    {
        # Check if Homebrew is installed
        test $(command -v brew)
    } || {
        # Check if individual dependencies are installed
        test $(command -v git) && \
        test $(command -v make) && \
        test $(command -v stow) && \
        test $(command -v zsh)
    }
}

# Clone dotfiles repository
clone_dotfiles_repo() {
    if [ ! -d ~/.dotfiles ]; then
        git clone https://github.com/zakharykaplan/dotfiles.git ~/.dotfiles
    fi
}

# Run script
main() {
    # Check for dependencies
    check_dependencies || {
        # If dependencies not found, do not install
        echo "Missing dependencies."
        test $(uname) == "Darwin" && \
            echo "  - recommended: brew"
        echo "  - required: git, make, stow, zsh"
        echo
        echo "Installation cancelled."
        return
    }

    # Clone dotfiles repository
    clone_dotfiles_repo

    # # Run Makefile
    make --directory=~/.dotfiles install

    # # Restart shell
    exec zsh -l
}

main "$@"
