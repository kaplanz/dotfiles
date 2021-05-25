#
#  env.zsh
#  Zsh environment plugin.
#
#  Created by Zakhary Kaplan on 2021-05-16.
#  Copyright © 2021 Zakhary Kaplan. All rights reserved.
#

# Print ${FPATH,PATH} in a human readable format.
alias fpath='echo ${FPATH//:/\\n}'
alias path='echo ${PATH//:/\\n}'

# Reload the shell environment.
function reload() { clear && exec "$SHELL" -l; }

# Re-run the last command as sudo.
function please() { sudo "$(fc -ln -1)"; }

# Copy remote files.
alias rsync='rsync -azhP --delete --stats'
alias scp='scp -r'
