#!/bin/bash
#
#  install.sh
#  Installer script.
#
#  Created by Zakhary Kaplan on 2019-06-05.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# -- Install programs --
# Dotfiles
install_dotfiles() {
    if [ ! -d ~/.dotfiles ]; then
        echo "Installing dotfiles.git..."
        git clone https://github.com/zakharykaplan/dotfiles.git ~/.dotfiles
        programs+="Dotfiles "
    fi
}

# Homebrew
install_homebrew() {
    if [ ! $(command -v brew) ] && [ $(uname) == "Darwin" ]; then
        echo "Installing Homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        programs+="Homebrew "
    fi
}

# Oh My Zsh
install_oh_my_zsh() {
    if [ ! -d ~/.oh-my-zsh ]; then
        echo "Installing Oh My Zsh..."
        if [ $(command -v curl) ]; then
            sh -c "$(echo "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" | sed 's/exec zsh -l//')"
            programs+="Oh-My-Zsh "
        elif [ $(command -v wget) ]; then
            sh -c "$(echo "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" | sed 's/exec zsh -l//')"
            programs+="Oh-My-Zsh "
        else
            echo "Warning: Oh-My-Zsh not installed"
        fi
    fi
}


# -- Set-up programs --
# Homebrew
setup_homebrew() {
    if [ $(command -v brew) ] && ! brew bundle --file=~/.dotfiles/tools/Brewfile check; then
        brew bundle --file=~/.dotfiles/tools/Brewfile
    fi
}

# tmux
setup_tmux() {
    # Directory structure
    if [ ! -d ~/.tmux ]; then
        echo "Setting up .tmux..."
        setup+=".tmux "
    fi
    mkdir -p ~/.tmux/themes

    # basic.tmux theme
    if [ ! -f ~/.tmux/themes/basic.tmux ]; then
        curl -o ~/.tmux/themes/basic.tmux https://raw.githubusercontent.com/jimeh/tmux-themepack/master/basic.tmuxtheme
        plugins+="basic.tmux "
    fi

    # tmux plugin manager (tpm)
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        plugins+="tpm "
    fi
}

# Vim
setup_vim() {
    # Directory structure
    if [ ! -d ~/.vim ]; then
        echo "Setting up .vim..."
        setup+=".vim "
    fi
    mkdir -p ~/.vim/{colors,pack/plugins,plugin,swap}

    # commentary.vim
    if [ ! -d ~/.vim/pack/plugins/start/commentary.vim ]; then
            git clone https://github.com/tpope/vim-commentary.git ~/.vim/pack/plugins/start/commentary.vim
            plugins+="commentary.vim "
    fi

    # fugitive.vim
    if [ ! -d ~/.vim/pack/plugins/start/fugitive.vim ]; then
            git clone https://github.com/tpope/vim-fugitive.git ~/.vim/pack/plugins/start/fugitive.vim
            plugins+="fugitive.vim "
    fi

    # jellybeans.vim
    if [ ! -f ~/.vim/colors/jellybeans.vim ]; then
        curl -o ~/.vim/colors/jellybeans.vim https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
        plugins+="jellybeans.vim "
    fi

    # lightline.vim
    if [ ! -d ~/.vim/pack/plugins/start/lightline.vim ]; then
        git clone https://github.com/itchyny/lightline.vim.git ~/.vim/pack/plugins/start/lightline.vim
        plugins+="lightline.vim "
    fi

    # nerdtree
    if [ ! -d ~/.vim/pack/plugins/start/nerdtree ]; then
        git clone https://github.com/scrooloose/nerdtree.git ~/.vim/pack/plugins/start/nerdtree
        plugins+="nerdtree "
    fi

    # surround.vim
    if [ ! -d ~/.vim/pack/plugins/start/surround.vim ]; then
            git clone https://github.com/tpope/vim-surround.git ~/.vim/pack/plugins/start/surround.vim
            plugins+="surround.vim "
    fi

    # syntastic
    if [ ! -d ~/.vim/pack/plugins/start/syntastic ]; then
        git clone https://github.com/vim-syntastic/syntastic.git ~/.vim/pack/plugins/start/syntastic
        plugins+="syntastic "
    fi

    # unimpaired.vim
    if [ ! -d ~/.vim/pack/plugins/start/unimpaired.vim ]; then
        git clone https://github.com/tpope/vim-unimpaired.git ~/.vim/pack/plugins/start/unimpaired.vim
        plugins+="unimpaired.vim "
    fi

    # vim-mucomplete
    if [ ! -d ~/.vim/pack/plugins/start/mucomplete.vim ]; then
        git clone https://github.com/lifepillar/vim-mucomplete.git ~/.vim/pack/plugins/start/mucomplete.vim
        plugins+="vim-mucomplete "
    fi

    # vim-multiple-cursors
    if [ ! -d ~/.vim/pack/plugins/start/vim-multiple-cursors ]; then
        git clone https://github.com/terryma/vim-multiple-cursors.git ~/.vim/pack/plugins/start/vim-multiple-cursors
        plugins+="vim-multiple-cursors "
    fi
}

# Zsh
setup_zsh() {
    # zsh-autosuggestions
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        plugins+="zsh-autosuggestions "
    fi

    # zsh-syntax-highlighting
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
        plugins+="zsh-syntax-highlighting "
    fi

    # Add to ~/.zshrc
    if [ $(grep "plugins=(" ~/.zshrc | wc -l) -gt 0 ]; then
        if [ $(uname) == "Darwin" ]; then
            sed -i "" "s/^plugins=(.*)$/plugins=$zsh_plugins/" ~/.zshrc
        elif [ $(uname) == "Linux" ]; then
            sed -i "s/^plugins=(.*)$/plugins=$zsh_plugins/" ~/.zshrc
        fi
    else
        echo "plugins=$zsh_plugins" >> ~/.zshrc
    fi
}


# -- Link dotfiles --
# Symlinks to home directory
link_to_home() {
    for dotfile in ${home_dotfiles[@]}; do
        if [ -f ~/$dotfile ] && [ ! -h ~/$dotfile ]; then
            mv ~/$dotfile ~/$dotfile.old
        fi

        if [ ! -h ~/$dotfile ]; then
            ln -s ~/.dotfiles/$dotfile ~/
            linked+="$dotfile "
        fi
    done
}

# Symlinks to elsewhere
link_tmux_theme() {
    # jellybeans.tmux
    if [ ! -h ~/.tmux/themes/jellybeans.tmux ]; then
        ln -sf ~/.dotfiles/jellybeans.tmux ~/.tmux/themes
        linked+="jellybeans.tmux "
    fi
}

link_vim_plugin() {
    # autopair.vim
    if [ ! -h ~/.vim/plugin/autopair.vim ]; then
        ln -sf ~/.dotfiles/autopair.vim ~/.vim/plugin
        linked+="autopair.vim "
    fi
}

link_zsh_theme() {
    # redefined.zsh-theme
    if [ ! -h ~/.oh-my-zsh/custom/themes/redefined.zsh-theme ]; then
        ln -sf ~/.dotfiles/redefined.zsh-theme ~/.oh-my-zsh/custom/themes
        linked+="redefined.zsh-theme "
    fi

    # Add to ~/.zshrc
    if [ $(grep 'ZSH_THEME="*"' ~/.zshrc | wc -l) -gt 0 ]; then
        if [ $(uname) == "Darwin" ]; then
            sed -i "" 's/ZSH_THEME=".*"/ZSH_THEME="redefined"/' ~/.zshrc
        elif [ $(uname) == "Linux" ]; then
            sed -i 's/ZSH_THEME=".*"/ZSH_THEME="redefined"/' ~/.zshrc
        fi
    else
        echo 'ZSH_THEME="redefined"' >> ~/.zshrc
    fi
}


# -- Installation report --
installation_report() {
    if [ ${!linked[@]} ] || [ ${!plugins[@]} ] || [ ${!programs[@]} ] || [ ${!setup[@]} ]; then
        echo "-------------------------"
        echo "-- Installation report --"
        echo "-------------------------"
    fi

    # Print installed programs
    [ ${!programs[@]} ] && echo "Programs:"
    for i in $programs; do
        echo "- $i"
    done

    # Print set-up program directories
    [ ${!setup[@]} ] && echo "Directories:"
    for i in $setup; do
        echo "- $i"
    done

    # Print set-up plugins
    [ ${!plugins[@]} ] && echo "Plugins:"
    for i in $plugins; do
        echo "- $i"
    done

    # Print linked dotfiles
    [ ${!linked[@]} ] && echo "Dotfiles:"
    for i in $linked; do
        echo "- $i"
    done

    echo "-------------------------"
    echo "Done!"
}


# -- Run script --
main() {
    echo "Starting install..."

    # Track installed
    linked=()
    plugins=()
    programs=()
    setup=()

    # Install options
    home_dotfiles=(.aliases .bash_profile .exports .functions .ignore .tmux.conf .vimrc .zprofile)
    zsh_plugins="(git zsh-autosuggestions zsh-syntax-highlighting)"

    # Install programs
    install_dotfiles
    install_homebrew
    install_oh_my_zsh

    # Set-up programs
    setup_homebrew
    setup_tmux
    setup_vim
    setup_zsh

    # Link dotfiles
    link_to_home
    link_tmux_theme
    link_vim_plugin
    link_zsh_theme

    # Installation report
    installation_report

    # Restart shell
    exec zsh -l
}

main
