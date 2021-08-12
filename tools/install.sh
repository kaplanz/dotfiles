#!/usr/bin/env bash
# File:        install.sh
# Author:      Zakhary Kaplan <https://zakharykaplan.ca>
# Created:     05 Jun 2019
# SPDX-License-Identifier: MIT

# Installation settings
DOTFILES=~/.dotfiles

# Check if minimum dependencies are installed
check_dependencies() {
    {
        # Check if Homebrew is installed
        test "$(command -v brew)"
    } || {
        # Check if individual dependencies are installed
        test "$(command -v git)" &&
        test "$(command -v make)" &&
        test "$(command -v stow)" &&
        test "$(command -v wget)" &&
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
    printf '  ' && print_dependency wget
    printf '  ' && print_dependency zsh
    echo 'Recommended:'
    printf '  ' && print_dependency nvim
    printf '  ' && print_dependency tmux
}

# Run script
main() {
    # Begin installation
    echo 'Install `zakharykaplan/dotfiles`'
    echo

    # Get options
    while getopts ":y" opt; do
        case ${opt} in
            y )
                YES=1
                ;;
        esac
    done
    shift $((OPTIND - 1))

    # Check for dependencies
    echo "Checking dependencies..."
    check_dependencies || {
        # If dependencies not found, do not install
        echo 'Installation cancelled. Please install missing dependencies and try again.'
        [ "$(uname)" = 'Darwin' ] &&
            echo 'Note: Homebrew could be used to satisfy all dependencies.'
        echo
        print_dependencies
        return 1
    }
    print_dependencies
    echo 'Dependencies satisfied. May proceed.'
    echo

    # Confirm installation
    echo "This will install dotfiles at: $DOTFILES"
    [ -z "$YES" ] && read -p "Proceed with installation? [Y/n] " PROCEED
    case "$PROCEED" in
        [Yy]* ) ;;
        ''    ) ;;
        *     )
            echo 'Installation cancelled.'
            return 1
            ;;
    esac
    echo

    # Clone dotfiles repository
    echo 'Cloning dotfiles repo...'
    clone_dotfiles_repo
    echo 'Done!'
    echo

    # Run Makefile
    echo 'Running Makefile...'
    make --directory=~/.dotfiles install
    echo 'Done!'
    echo

    # Complete installation
    echo 'Installation complete. Please use responsibly!'
}

main "$@"
