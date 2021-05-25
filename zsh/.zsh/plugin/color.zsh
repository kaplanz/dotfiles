#
#  color.zsh
#  Zsh colours plugin.
#
#  Created by Zakhary Kaplan on 2021-05-19.
#  Copyright © 2021 Zakhary Kaplan. All rights reserved.
#

# Override default utils with GNU coreutils
[ "$(command -v gdircolors)" ] && alias dircolors='gdircolors'

# Figure out which version of `ls` we've got
if ls --color -d . &> /dev/null; then
    alias ls='ls --color=auto'
elif ls -G -d . &> /dev/null; then
    [ "$(command -v gls)" ] \
        && alias ls='gls --color=auto' \
        || alias ls='ls -G'
fi

# Set colours used by ls, etc.
export DIRCOLORS="$DOTFILES/colors/dircolors/redefined.dircolors"
eval $(dircolors "$DIRCOLORS")

# Take advantage of $LS_COLORS for completion.
[ ! -z "$LS_COLORS" ] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
