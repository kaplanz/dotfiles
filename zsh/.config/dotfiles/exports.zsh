#
#  exports.zsh
#  Zsh exports.
#
#  Created by Zakhary Kaplan on 2019-06-04.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# --------------------------------
#             Exports
# --------------------------------

# -- Directories --
export DOTFILES="$HOME/.dotfiles"

# -- Environment --
export EDITOR="$(command -v vim)"
export PAGER="$(command -v less)"

# -- Filesystem --
export LS_COLORS="$(cat $DOTFILES/colors/jellybeans.lscolors | tr '\n' ':')"
export TREE_IGNORE='.git'

# -- Path --
# XDG
export PATH="$HOME/.local/bin:$PATH"

# -- Utilities --
# bat
export BAT_THEME='Nord'
# fzf
export FZF_DEFAULT_COMMAND='fd'
export FZF_DEFAULT_OPTS="
    --bind '?:toggle-preview'
    --bind 'ctrl-a:toggle-all'
    --bind 'ctrl-v:execute(echo {+} | xargs -o vim)'
    --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
    --color='prompt:25,pointer:110,marker:222'
    --exit-0
    --info=inline
    --multi
    --prompt='~ '
    --select-1"
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'
export FZF_CTRL_T_OPTS="
    --preview '([[ -d {} ]] && (tree -C {})) ||
               ([[ -f {} ]] &&
                   (! grep -Iq . {} && file {}) ||
                   bat --style=numbers --color=always {} ||
                   cat {}
               ) ||
               (echo {} 2> /dev/null | head -200)'"
export FZF_CTRL_R_OPTS="
    --sort
    --preview 'echo {}'
    --preview-window down:3:hidden:wrap"
export FZF_ALT_C_COMMAND='$FZF_DEFAULT_COMMAND --type d'
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# vim:ft=sh:
