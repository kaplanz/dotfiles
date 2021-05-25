#
#  dotfiles.zsh
#  Zsh dotfiles plugin.
#
#  Created by Zakhary Kaplan on 2021-05-16.
#  Copyright © 2021 Zakhary Kaplan. All rights reserved.
#

# Set the path to the dotfiles repo.
export DOTFILES="$HOME/.dotfiles"

# Upgrade the dotfiles repo
function upgrade_dotfiles() { "$DOTFILES/tools/upgrade.sh" "$@"; }
