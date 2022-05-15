# File:        dotfiles.zsh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     16 May 2021
# SPDX-License-Identifier: MIT

export DOTFILES="$HOME/.dotfiles"

# Upgrade the dotfiles repo
function upgrade_dotfiles() { bash "$DOTFILES/tools/upgrade.sh" "$@"; }
