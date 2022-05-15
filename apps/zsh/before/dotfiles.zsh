# File:        dotfiles.zsh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     16 May 2021
# SPDX-License-Identifier: MIT

# Set the path to the dotfiles repo.
export DOTFILES="$HOME/.dotfiles"

# Upgrade the dotfiles repo
function upgrade_dotfiles() { "$DOTFILES/tools/upgrade.sh" "$@"; }
