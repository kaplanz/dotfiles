# File:        color.zsh
# Author:      Zakhary Kaplan <https://zakharykaplan.ca>
# Created:     19 May 2021
# SPDX-License-Identifier: MIT

# Override default utils with GNU coreutils.
[ "$(command -v gdircolors)" ] && alias dircolors='gdircolors'

# Set colours used by ls, etc.
export DIRCOLORS="$DOTFILES/colors/dircolors/redefined.dircolors"
eval $(dircolors "$DIRCOLORS")

# Take advantage of $LS_COLORS for completion as well.
[[ -n "$LS_COLORS" ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Find the option for using colors in ls, depending on the version.
if [[ "$OSTYPE" == netbsd* ]]; then
  # On NetBSD, test if "gls" (GNU ls) is installed (this one supports colors);
  # otherwise, leave ls as is, because NetBSD's ls doesn't support -G
  gls --color -d . &> /dev/null && alias ls='gls --color=tty'
elif [[ "$OSTYPE" == openbsd* ]]; then
  # On OpenBSD, "gls" (ls from GNU coreutils) and "colorls" (ls from base,
  # with color and multibyte support) are available from ports.  "colorls"
  # will be installed on purpose and can't be pulled in by installing
  # coreutils, so prefer it to "gls".
  gls --color -d . &> /dev/null && alias ls='gls --color=tty'
  colorls -G -d . &> /dev/null && alias ls='colorls -G'
elif [[ "$OSTYPE" == (darwin|freebsd)* ]]; then
  # this is a good alias, it works by default just using $LSCOLORS
  ls -G . &> /dev/null && alias ls='ls -G'

  # only use coreutils ls if there is a dircolors customization present ($LS_COLORS or .dircolors file)
  # otherwise, gls will use the default color scheme which is ugly af
  [[ -n "$LS_COLORS" || -f "$HOME/.dircolors" ]] && gls --color -d . &> /dev/null && alias ls='gls --color=tty'
else
  # For GNU ls, we use the default ls color theme. They can later be overwritten by themes.
  if [[ -z "$LS_COLORS" ]]; then
    (( $+commands[dircolors] )) && eval "$(dircolors -b)"
  fi

  ls --color -d . &> /dev/null && alias ls='ls --color=tty' || { ls -G . &> /dev/null && alias ls='ls -G' }
fi
