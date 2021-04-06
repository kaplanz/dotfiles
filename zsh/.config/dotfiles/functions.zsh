#
#  functions.zsh
#  Zsh functions.
#
#  Created by Zakhary Kaplan on 2019-06-04.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# --------------------------------
#            Functions
# --------------------------------

# -- Developer --
function runc() { cc ${@:-*.c} && ./a.out && rm a.out; }
function runcpp() { c++ -std=c++2a ${@:-*.cpp} && ./a.out && rm a.out; }
function sourcecode() {
    [ -z "$SOURCECODE" ] && \
        echo "sourcecode: could not find sourcecode template." && \
        return

    local description="\[Description\]"
    [ ! $2 ] && echo -n "Comment prefix: " && read 2
    [ ! $3 ] && echo -n "Description: " && read 3
    mkdir -p $(dirname $1)
    cat "$SOURCECODE" |
        sed "s/template.txt/$(basename ${1:-template.txt})/" |
        sed "s|//|${2:-//}|" |
        sed "s/$description/${3:-$description}/" |
        sed "s/1970-01-01/$(date +%F)/" |
        sed "s/1970/$(date +%Y)/" > $1
    cat $1
}

# -- Dotfiles --
function upgrade_dotfiles() { bash "$DOTFILES/tools/upgrade.sh" "$@"; }

# -- Filesystem --
function mv!() {
    [ -e "$1" ] && mkdir -p "$(dirname $2)"
    mv "$1" "$2"
}
function cp!() {
    [ -e "$1" ] && mkdir -p "$(dirname $2)"
    cp -R "$1" "$2"
}
function trash() { mv -f $@ ~/.Trash; }

# -- Utilities --
# fzf
function _fzf_compgen_path() { fd --hidden --follow . "$1"; }
function _fzf_compgen_dir() { fd --hidden --follow --type d . "$1"; }
# tmux
function tas() { tmux attach-session ${1:+"-t$1"}; }
function tkss() { tmux kill-session ${1:+"-t$1"}; }
function tns() { tmux new-session -s ${1:-"${${PWD##*/}//.}"}; }

# vim:ft=sh:
