#!/bin/bash
#
#  upgrade_dotfiles.sh
#  Cron script to upgrade dotfiles.
#
#  Created by Zakhary Kaplan on 2020-06-13.
#  Copyright © 2020 Zakhary Kaplan. All rights reserved.
#

# Set environment variable DOTFILES
DOTFILES=${DOTFILES:-"$HOME/.dotfiles"}

# Run dotfiles upgrade script
env DOTFILES="$DOTFILES" "$DOTFILES/tools/upgrade.sh"
