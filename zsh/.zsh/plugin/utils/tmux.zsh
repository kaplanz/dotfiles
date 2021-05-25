#
#  tmux.zsh
#  Zsh Tmux plugin.
#
#  Created by Zakhary Kaplan on 2021-05-16.
#  Copyright © 2021 Zakhary Kaplan. All rights reserved.
#

alias t='tmux'
alias tksv='tmux kill-server'
alias tls='tmux list-sessions'
alias tv="tmux new-session 'vim'"
function tas() { tmux attach-session ${1:+"-t$1"}; }
function tkss() { tmux kill-session ${1:+"-t$1"}; }
function tns() { tmux new-session -s ${1:-"${${PWD##*/}//.}"}; }
