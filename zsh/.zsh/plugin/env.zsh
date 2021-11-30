# File:        env.zsh
# Author:      Zakhary Kaplan <https://zakharykaplan.ca>
# Created:     16 May 2021
# SPDX-License-Identifier: MIT

# Print ${FPATH,PATH} in a human readable format.
alias fpath='echo ${FPATH//:/\\n}'
alias path='echo ${PATH//:/\\n}'

# Reload the shell environment.
function reload() { clear && exec "$SHELL" -l; }

# Re-run the last command as sudo.
function please() { sudo $(fc -ln -1); }

# Copy remote files.
alias rsync='rsync -azhP --stats'
alias scp='scp -r'

# Launch info with vi-keys
alias info='info --vi-keys'
