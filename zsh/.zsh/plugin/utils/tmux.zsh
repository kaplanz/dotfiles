# File:        tmux.zsh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     16 May 2021
# SPDX-License-Identifier: MIT

alias t='tmux'
alias tksv='tmux kill-server'
alias tls='tmux list-sessions'
alias tv="tmux new-session 'nvim'"
function tas() { tmux attach-session ${1:+"-t$1"}; }
function tkss() { tmux kill-session ${1:+"-t$1"}; }
function tns() { tmux new-session -s ${1:-"${${PWD##*/}//(#s)./}"}; }
