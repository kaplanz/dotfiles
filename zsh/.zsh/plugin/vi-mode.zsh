# File:        vi-mode.zsh
# Author:      Zakhary Kaplan <https://zakharykaplan.ca>
# Created:     27 May 2021
# SPDX-License-Identifier: MIT

# If not in vi-mode, don't do anything.
case "$(bindkey -lL main)" in
    *viins*) ;;
          *) return;;
esac

# -- Bindkeys -- {{{
# Edit the command line using your visual editor, as in ksh.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Move up a line in the buffer, or if already at the top line, move to the
# previous event in the history list.
bindkey '^P' up-line-or-history
# Move down a line in the buffer, or if already at the bottom line, move to
# the next event in the history list.
bindkey '^N' down-line-or-history

# Back up one place in the search history.
bindkey '^H' backward-delete-char
bindkey '^?' backward-delete-char
# Back up one character in the minibuffer.
bindkey '^W' backward-kill-word

# Move to the beginning of the line.
bindkey '^A' beginning-of-line
# Move to the end of the line.
bindkey '^E' end-of-line

# Push  the  current  buffer onto the buffer stack and clear the buffer.
bindkey "^Q" push-line

# Move to the beginning of the previous word, vi-style.
bindkey '^[b' vi-backward-word
# Move forward one word, vi-style.
bindkey '^[f' vi-forward-word
# }}}

# -- Exports -- {{{
# Shorten delay when switching to `vicmd` keymap.
export KEYTIMEOUT=1
# }}}

# -- Functions -- {{{
function _zsh_set_cursor_shape_for_keymap() {
    # https://vt100.net/docs/vt510-rm/DECSCUSR
    local shape=0
    case "${1:-${KEYMAP:-main}}" in
        main)    shape=6 ;; # vi insert: line
        viins)   shape=6 ;; # vi insert: line
        isearch) shape=6 ;; # inc search: line
        command) shape=6 ;; # read a command name
        vicmd)   shape=2 ;; # vi cmd: block
        visual)  shape=2 ;; # vi visual mode: block
        viopp)   shape=0 ;; # vi operation pending: blinking block
        *)       shape=0 ;;
    esac
    printf $'\e[%d q' "${shape}"
}
# }}}

# -- Widgets -- {{{
# Updates editor information when the keymap changes.
function zle-keymap-select() {
    # Set the prompt variable
    ZSH_PROMPT_VAR_VIMODE="$(prompt_redefined_vimode)"
    # Set the cursor shape for the keymap
    _zsh_set_cursor_shape_for_keymap "${KEYMAP}"
    # Reset the prompt on a mode change
    zle reset-prompt
    zle -R
}
zle -N zle-keymap-select

# These "echoti" statements were originally set in lib/key-bindings.zsh
# Not sure the best way to extend without overriding.
function zle-line-init() {
    local prev_keymap="${KEYMAP:-}"
    [[ "$prev_keymap" != 'main' ]] && zle reset-prompt
    (( ! ${+terminfo[smkx]} )) || echoti smkx
    _zsh_set_cursor_shape_for_keymap "${KEYMAP}"
}
zle -N zle-line-init

function zle-line-finish() {
    (( ! ${+terminfo[rmkx]} )) || echoti rmkx
    _zsh_set_cursor_shape_for_keymap default
}
zle -N zle-line-finish
# }}}

# vim:fdl=0:fdm=marker:
