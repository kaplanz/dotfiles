#!/bin/sh
#
#  install.sh
#  Install script.
#
#  Created by Zakhary Kaplan on 2019-06-05.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

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
    [ ! -d ~/.dotfiles ] && {
        git clone https://github.com/zakharykaplan/dotfiles.git ~/.dotfiles
    }
}

# Run script
main() {
    # Check for dependencies
    check_dependencies || {
        # If dependencies not found, do not install
        echo 'Installation cancelled. Please install missing dependencies and try again.'
        [ "$(uname)" = 'Darwin' ] && \
            echo 'Note: Homebrew could be used to satisfy all dependencies.'
        echo
        echo 'Required:'
        printf '  %s git\n' "$(test $(command -v git) && echo '✓' || echo '✗')"
        printf '  %s make\n' "$(test $(command -v make) && echo '✓' || echo '✗')"
        printf '  %s stow\n' "$(test $(command -v stow) && echo '✓' || echo '✗')"
        printf '  %s zsh\n' "$(test $(command -v zsh) && echo '✓' || echo '✗')"
        echo 'Recommended:'
        printf '  %s tmux\n' "$(test $(command -v tmux) && echo '✓' || echo '✗')"
        printf '  %s vim\n' "$(test $(command -v vim) && echo '✓' || echo '✗')"
        return
    }

    # Clone dotfiles repository
    clone_dotfiles_repo

    # Run Makefile
    make --directory=~/.dotfiles install
}

main "$@"
