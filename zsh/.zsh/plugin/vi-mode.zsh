#
#  vi-mode.zsh
#  Zsh vi-mode plugin.
#
#  Created by Zakhary Kaplan on 2021-05-27.
#  Copyright © 2021 Zakhary Kaplan. All rights reserved.
#

# If not in vi-mode, don't do anything.
case "$(bindkey -lL main)" in
    *viins*) ;;
          *) return;;
esac

# Shorten delay when switching to `vicmd` keymap.
export KEYTIMEOUT=1

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
