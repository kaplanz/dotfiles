#
#  .zprofile
#  Zsh profile.
#
#  Created by Zakhary Kaplan on 2019-05-13.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# --------------------------------
#             Exports
# --------------------------------

export ALIASES="$HOME/.config/dotfiles/aliases.zsh"
export EXPORTS="$HOME/.config/dotfiles/exports.zsh"
export FUNCTIONS="$HOME/.config/dotfiles/functions.zsh"


# --------------------------------
#             Sources
# --------------------------------

[ -f "$ALIASES" ] && source "$ALIASES"
[ -f "$EXPORTS" ] && source "$EXPORTS"
[ -f "$FUNCTIONS" ] && source "$FUNCTIONS"
[ -f "$HOME/.localrc" ] && source "$HOME/.localrc"
[ -f "$HOME/.profile" ] && source "$HOME/.profile"


# --------------------------------
#             Options
# --------------------------------

setopt cshnullglob
setopt extendedglob
setopt noclobber
