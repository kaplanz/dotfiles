#!/bin/sh
#
#  install.sh
#  Installer script.
#
#  Created by Zakhary Kaplan on 2019-06-05.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#


echo "Starting install..."

# -- Install Programs --
programs=()

# Install dotfiles.git
if [ ! -d ~/.dotfiles ]; then
    echo "Installing dotfiles.git..."
    git clone https://github.com/zakharykaplan/dotfiles.git ~/.dotfiles
    programs+="dotfiles.git "
else # Update repo
    sh -c "cd ~/.dotfiles && git pull"
fi

# Install Homebrew
if [ ! $(command -v brew) ]; then
    if [ $(uname) == "Darwin" ] && [ $(command -v curl) ]; then
        echo "Installing Homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        programs+="Homebrew "
    else
        echo "Warning: Homebrew not installed"
    fi
fi

# Install Oh My Zsh
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing Oh My Zsh..."
    if [ $(command -v curl) ]; then
        sh -c "$(echo "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" | sed "s/exec zsh -l//")"
        programs+="Oh-My-Zsh "
    elif [ $(command -v wget) ]; then
        sh -c "$(echo "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" | sed "s/exec zsh -l//")"
        programs+="Oh-My-Zsh "
    else
        echo 'Warning: Oh-My-Zsh not installed'
    fi
fi

# Install .vim
if [ ! -d ~/.vim ]; then
    echo "Installing .vim..."
    mkdir ~/.vim
    mkdir ~/.vim/colors
    mkdir ~/.vim/pack
    mkdir ~/.vim/pack/plugins
    mkdir ~/.vim/swap
    programs+=".vim "
fi


# -- Set-up plugins --
plugins=()

# Vim
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

# Zsh
zsh_plugins="(git zsh-autosuggestions zsh-syntax-highlighting)"

# zsh-autosuggestions
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] && [ $(grep "zsh-autosuggestions" ~/.zshrc | wc -l) -eq 0 ]; then
   git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
   plugins+="zsh-autosuggestions "
fi

# zsh-syntax-highlighting
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] && [ $(grep "zsh-syntax-highlighting" ~/.zshrc | wc -l) -eq 0 ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    plugins+="zsh-syntax-highlighting "
fi

# Add to ~/.zshrc
if [ $(grep 'plugins=(' ~/.zshrc | wc -l) -gt 0 ]; then
    if [ $(uname) == "Darwin" ]; then
        sed -i '' "s/^plugins=(.*)$/plugins=$zsh_plugins/" ~/.zshrc
    elif [ $(uname) == "Linux" ]; then
        sed -i "s/^plugins=(.*)$/plugins=$zsh_plugins/" ~/.zshrc
    fi
else
    echo "plugins=$zsh_plugins" >> ~/.zshrc
fi


# -- Link Dotfiles --
linked=()

# Symlinks to home directory
home_dotfiles=(.aliases .bash_profile .exports .functions .tmux.conf .vimrc .zprofile)
for dotfile in ${home_dotfiles[@]}; do
    if [ -f ~/$dotfile ] && [ ! -h ~/$dotfile ]; then
        mv ~/$dotfile ~/$dotfile.old
    fi

    if [ ! -h ~/$dotfile ]; then
        ln -s ~/.dotfiles/$dotfile ~/
        linked+="$dotfile "
    fi
done

# Symlinks to elsewhere
if [ ! -h ~/.oh-my-zsh/custom/themes/redefined.zsh-theme ]; then
    ln -sf ~/.dotfiles/redefined.zsh-theme ~/.oh-my-zsh/custom/themes
    linked+="redefined.zsh-theme "
fi

# Add to ~/.zshrc
if [ $(grep 'ZSH_THEME="*"' ~/.zshrc | wc -l) -gt 0 ]; then
    if [ $(uname) == "Darwin" ]; then
        sed -i '' 's/ZSH_THEME=".*"/ZSH_THEME="redefined"/' ~/.zshrc
    elif [ $(uname) == "Linux" ]; then
        sed -i 's/ZSH_THEME=".*"/ZSH_THEME="refined"/' ~/.zshrc
    fi
else
    [ $(uname) == "Darwin" ] && echo 'ZSH_THEME="redefined"' >> ~/.zshrc
    [ $(uname) == "Linux" ] && echo 'ZSH_THEME="refined"' >> ~/.zshrc
fi


# -- Installation report --
if [ ${!programs[@]} ] || [ ${!linked[@]} ]; then
    echo "-------------------------"
    echo "-- Installation report --"
    echo "-------------------------"
fi

# Print installed programs
[ ${!programs[@]} ] && echo "Programs:"
for i in $programs; do
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

# Restart shell
exec zsh -l
