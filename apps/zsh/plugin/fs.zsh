# File:        fs.zsh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     13 May 2021
# SPDX-License-Identifier: MIT
# Vim:         set fdl=0 fdm=marker:

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
# Use `eza` instead of `ls`
if command -v eza &> /dev/null; then
    alias ls='eza --binary --classify --git --git-ignore --icons'
    alias tree='ls -T'
fi
# List aliases
alias l='la'
alias la='ls -la'
alias ll='ls -l'

# List contents of directories in a tree-like format.
for i in {1..9}; do
    alias tree$i="tree -L $i"
done
# }}}
