#
#  redefined.zsh-theme
#  My zsh theme.
#
#  Created by Zakhary Kaplan on 2019-05-13.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# Colour vars
DeepSkyBlue2='031'
SeaGreen3='078'
LightSlateGrey='103'
DarkOliveGreen3='107'
MediumPurple1='141'
Orange1='214'
Grey7='233'
Grey19='236'
Grey42='242'
Grey58='246'

# Prompt blocks
conda_env_block='${CONDA_DEFAULT_ENV:+"%F{$Grey19}%K{$DarkOliveGreen3} $CONDA_DEFAULT_ENV %f%k"}'
hostname_block='${SSH_TTY:+"%F{$Grey19}%K{$LightSlateGrey} %n@%m %f%k"}'
time_block='%F{$Grey42}%K{$Grey7} %D{%X} %f%k'
date_block='%F{$Grey58}%K{$Grey19} %D{%x} %f%k'

# Primary prompt
PROMPT='%F{$DeepSkyBlue2}%~$(git_prompt_info) %F{$MediumPurple1}%(!.#.»)%f '

# Right prompt
RPROMPT="${conda_env_block}${hostname_block}${time_block}${date_block}"
ZLE_RPROMPT_INDENT=-1

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{$DeepSkyBlue2}(%F{$SeaGreen3}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{$DeepSkyBlue2})%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{$Orange1}*"

# Displays the exec time of the last command if set threshold was exceeded
cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt 5 ] && print -P "%F{yellow}${elapsed}s%f"
}

# Get the initial timestamp for cmd_exec_time
preexec() {
    cmd_timestamp=`date +%s`
}

# Output information about exec time
precmd() {
    cmd_exec_time
    unset cmd_timestamp # Reset cmd exec time
}


# --------------------------------
#            References
# --------------------------------
#
# af-magic.zsh-theme: https://github.com/andyfleming/oh-my-zsh
# pure.zsh-theme: https://github.com/sindresorhus
