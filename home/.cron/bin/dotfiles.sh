#!/usr/bin/env bash
# File:        dotfiles.sh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     13 Jun 2020
# SPDX-License-Identifier: MIT

# Set environment variable DOTFILES
DOTFILES=${DOTFILES:-"$HOME/.dotfiles"}

# Run dotfiles upgrade script
env DOTFILES="$DOTFILES" "$DOTFILES/tools/upgrade.sh"
