# File:        fs.zsh
# Author:      Zakhary Kaplan <https://zakharykaplan.ca>
# Created:     13 May 2021
# SPDX-License-Identifier: MIT

# -- Options -- {{{
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
# }}}

# -- Directories -- {{{
# Ancestors
alias -g ..1='..'
alias -g ..2='../..'
alias -g ..3='../../..'
alias -g ..4='../../../..'
alias -g ..5='../../../../..'
alias -g ..6='../../../../../..'
alias -g ..7='../../../../../../..'
alias -g ..8='../../../../../../../..'
alias -g ..9='../../../../../../../../..'
alias -g ..='..1'
alias -g ...='..2'
alias -g ....='..3'
alias -g .....='..4'
alias -g ......='..5'
alias -g .......='..6'
alias -g ........='..7'
alias -g .........='..8'
alias -g ..........='..9'
# Directory stack
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
function d() {
    if [[ -n $1 ]]; then
        dirs "$@"
    else
        dirs -v | head -10
    fi
}
# compdef _dirs d
# Edit directories
alias md='mkdir -p'
alias rd='rmdir'
function take() {
  mkdir -p $@ && cd ${@:$#}
}
alias takenow='take $(date +"%Y/%m/%d")'
# List directory contents
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias lsa='ls -lah'
# }}}

# -- Files -- {{{
# Creation and deletion
alias cp='cp -R'
function cp!() {
    [ -e "$1" ] && mkdir -p "$(dirname $2)"
    cp -R "$1" "$2"
}
function mv!() {
    [ -e "$1" ] && mkdir -p "$(dirname $2)"
    mv "$1" "$2"
}
function mvall() { mv {^,}"$1"; }
alias rm='rm -d'
# }}}

# -- Filesystem -- {{{
# List contents of directories in a tree-like format.
export TREE_IGNORE='.git'
alias tree='tree -I "$TREE_IGNORE"'
for i in {1..9}; do
    alias tree$i="tree -L $i"
done
# }}}

# vim:fdl=0:fdm=marker:
