# File:        fzf.zsh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     16 May 2021
# SPDX-License-Identifier: MIT

# Source fzf configuration files
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Configure completion
function _fzf_compgen_path() { fd --hidden --follow . "$1"; }
function _fzf_compgen_dir() { fd --hidden --follow --type d . "$1"; }

# Configure environment variables
export FZF_DEFAULT_COMMAND='fd'
export FZF_DEFAULT_OPTS="
    --bind '?:toggle-preview'
    --bind 'ctrl-a:toggle-all'
    --bind 'ctrl-v:execute(echo {+} | xargs -o "$EDITOR")'
    --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
    --color='prompt:25,pointer:110,marker:222'
    --exit-0
    --info=inline
    --multi
    --prompt='~ '
    --select-1
"
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND --strip-cwd-prefix'
export FZF_CTRL_T_OPTS="
    --preview '([[ -d {} ]] && (exa -T {})) ||
               ([[ -f {} ]] &&
                   (! grep -Iq . {} && file {}) ||
                   bat --style=numbers --color=always {} ||
                   cat {}
               ) ||
               (echo {} 2> /dev/null | head -200)'
"
export FZF_CTRL_R_OPTS="
    --sort
    --preview 'echo {}'
    --preview-window down:3:hidden:wrap
"
export FZF_ALT_C_COMMAND='$FZF_DEFAULT_COMMAND --type d --follow --strip-cwd-prefix'
export FZF_ALT_C_OPTS="--preview 'exa -T {}'"
