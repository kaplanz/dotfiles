#!/usr/bin/env bash
# File:        install.sh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     05 Jun 2019
# SPDX-License-Identifier: MIT

# Parameters
DOTFILES=${DOTFILES:-~/.dotfiles}

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
    dep-check || {
        # If dependencies not found, do not install
        echo 'Installation cancelled. Please install missing dependencies and try again.'
        [ "$(uname)" = 'Darwin' ] &&
            echo 'Note: Homebrew could be used to satisfy all dependencies.'
        echo
        dep-printall
        return 1
    }
    dep-printall
    echo 'Dependencies satisfied. May proceed.'
    echo

    # Confirm installation
    echo "This will install at: \`$DOTFILES\`"
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
    dots-clone
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

# Check if minimal dependencies are installed
dep-check() {
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

# Print all dependencies
dep-printall() {
    echo 'Required:'
    printf '  ' && dep-print git
    printf '  ' && dep-print make
    printf '  ' && dep-print stow
    printf '  ' && dep-print wget
    printf '  ' && dep-print zsh
    echo 'Recommended:'
    printf '  ' && dep-print nvim
    printf '  ' && dep-print tmux
}

# Print a single dependency
dep-print() {
    printf "%s $1\n" "$(command -v $1 &> /dev/null && echo '✓' || echo '✗')"
}

# Clone dotfiles repository
dots-clone() {
    [ ! -d "$DOTFILES" ] && {
        git clone https://github.com/zakharykaplan/dotfiles.git "$DOTFILES"
    } || {
        echo "Ditectory already exists at path: \`$DOTFILES\`"
    }
}

main "$@"
