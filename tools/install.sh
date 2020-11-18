#!/bin/sh
#
#  install.sh
#  Install script.
#
#  Created by Zakhary Kaplan on 2019-06-05.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# Installation settings
DOTFILES=~/.dotfiles

# Check if minimum dependencies are installed
check_dependencies() {
    {
        # Check if Homebrew is installed
        test "$(command -v brew)"
    } || {
        # Check if individual dependencies are installed
        test "$(command -v git)" && \
        test "$(command -v make)" && \
        test "$(command -v stow)" && \
        test "$(command -v zsh)"
    }
}

# Clone dotfiles repository
clone_dotfiles_repo() {
    [ ! -d "$DOTFILES" ] && {
        git clone https://github.com/zakharykaplan/dotfiles.git "$DOTFILES"
    }
}

# Helpers
print_dependency() {
    printf "%s $1\n" "$(test $(command -v $1) && echo '✓' || echo '✗')"
}

print_dependencies() {
    echo 'Required:'
    printf '  ' && print_dependency git
    printf '  ' && print_dependency make
    printf '  ' && print_dependency stow
    printf '  ' && print_dependency zsh
    echo 'Recommended:'
    printf '  ' && print_dependency tmux
    printf '  ' && print_dependency vim
}

# Run script
main() {
    # Begin installation
    echo 'Dofiles Installer'
    echo

    # Check for dependencies
    echo "Checking dependencies..."
    check_dependencies || {
        # If dependencies not found, do not install
        echo 'Installation cancelled. Please install missing dependencies and try again.'
        [ "$(uname)" = 'Darwin' ] && \
            echo 'Note: Homebrew could be used to satisfy all dependencies.'
        echo
        print_dependencies
        return 1
    }
    print_dependencies
    echo 'Dependencies satisfied. May proceed.'
    echo

    # Check if already installed
    echo 'Checking installation path...'
    echo "DOTFILES = $DOTFILES"
    [ -f "$DOTFILES" ] || {
        echo "Installation cancelled. Path not empty."
        return 1
    }
    echo 'Path is empty. May proceed.'
    echo

    # Confirm installation
    echo "This will install dotfiles at: $DOTFILES"
    printf "Proceed with installation [Y/n]? "
    read PROCEED
    [ "$PROCEED" = 'N' ] || [ "$PROCEED" = 'n' ] && {
        return 1
    }

    # Clone dotfiles repository
    echo 'Cloning dotfiles repo...'
    clone_dotfiles_repo
    echo

    # Run Makefile
    echo 'Running Makefile...'
    make --directory=~/.dotfiles install
    echo

    # Complete installation
    echo 'Installation complete. Please use responsibly!'
}

main "$@"
