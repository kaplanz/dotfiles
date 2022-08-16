# File:        color.zsh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     19 May 2021
# SPDX-License-Identifier: MIT

# Override default utils with GNU coreutils.
[ "$(command -v gdircolors)" ] && alias dircolors='gdircolors'

# Set colours used by ls, etc.
export DIRCOLORS="$DOTFILES/share/dircolors/playtime.dircolors"
eval $(dircolors "$DIRCOLORS")

# Take advantage of $LS_COLORS for completion as well.
[[ -n "$LS_COLORS" ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
