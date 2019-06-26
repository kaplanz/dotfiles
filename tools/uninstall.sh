#!/bin/bash
#
#  uninstall.sh
#  Uninstaller script.
#
#  Created by Zakhary Kaplan on 2019-06-18.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# -- Unlink dotfiles --
# Symlinks from home directory
unlink_from_home() {
    for dotfile in ${home_dotfiles[@]}; do
       if [ -h ~/$dotfile ]; then
            unlink ~/$dotfile
            unlinked+="$dotfile "
        fi
    done
}

# Symlinks from elsewhere
unlink_zsh_theme() {
    if [ -h ~/.oh-my-zsh/custom/themes/redefined.zsh-theme ]; then
        rm ~/.oh-my-zsh/custom/themes/redefined.zsh-theme
        unlinked+="redefined.zsh-theme "
    fi
}

# -- Uninstallation Report --
uninstallation_report() {
    if [ ${!unlinked[@]} ]; then
        echo "---------------------------"
        echo "-- Uninstallation report --"
        echo "---------------------------"
    fi

    # Print unlinked dotfiles
    [ ${!unlinked[@]} ] && echo "Dotfiles:"
    for i in $unlinked; do
        echo "- $i"
    done

    echo "---------------------------"
    echo "Done!"
}


# -- Run script --
main(){
    echo "Starting uninstall..."

    # Track uninstalled
    unlinked=()

    # Uninstall options
    home_dotfiles=(.aliases .bash_profile .exports .functions .tmux.conf .vimrc .zprofile)

    # Unlink dotfiles
    unlink_from_home
    unlink_zsh_theme

    # Uninstallation report
    uninstallation_report

    # Restart shell
    exec zsh -l
}

main
