#
#  redefined.zsh-theme
#  My zsh theme.
#
#  Created by Zakhary Kaplan on 2019-05-13.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# Load zsh modules
zmodload zsh/datetime

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
vi_mode_block='%F{$VI_COLOUR}%K{$Grey7}${VI_MODE}%f%k'
command_time_block='${command_time:+"%F{$Grey42}%K{$Grey7} $command_time %f%k"}'
conda_env_block='${CONDA_DEFAULT_ENV:+"%F{$DarkOliveGreen3}%K{$Grey7} $CONDA_DEFAULT_ENV "}'
hostname_block='${SSH_TTY:+"%F{$DeepSkyBlue2}%K{$Grey7} %n@%m "}'
time_block='%F{$Grey58}%K{$Grey19} %D{%X}' # Use ZLE_RPROMPT_INDENT as final whitespace

# Primary prompt
PROMPT='%k%F{$DeepSkyBlue2}%~$(git_prompt_info) %F{$MediumPurple1}%(!.#.»)%f '

# Right prompt
RPROMPT="${vi_mode_block}${command_time_block}${conda_env_block}${hostname_block}${time_block}%E"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{$DeepSkyBlue2}(%F{$SeaGreen3}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{$DeepSkyBlue2})%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{$Orange1}*"

# Vi mode
function zle-line-init zle-keymap-select {
    VI_MODE="${${KEYMAP/vicmd/ NORMAL }/(main|viins)/ INSERT }"
    VI_COLOUR="${${KEYMAP/vicmd/$LightSlateGrey}/(main|viins)/$DarkOliveGreen3}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

function _reset-prompt-and-accept-line {
    unset VI_MODE VI_COLOUR
    zle reset-prompt
    zle .accept-line # Note the . meaning the built-in accept-line
}
zle -N accept-line _reset-prompt-and-accept-line

# Calculate command execution time
get_command_time() {
    local stop=$EPOCHREALTIME
    local start=${timestamp:-$stop}
    let local elapsed=$stop-$start
    (( $elapsed > 0 )) && printf "%.2fs" $elapsed
}

# Get the initial command timestamp
preexec() {
    timestamp=$EPOCHREALTIME
}

# Get the elapsed command execution time
precmd() {
    command_time=$(get_command_time)
    unset timestamp # Reset timestamp
}


# --------------------------------
#            References
# --------------------------------
#
# af-magic.zsh-theme: https://github.com/andyfleming/oh-my-zsh
# pure.zsh-theme: https://github.com/sindresorhus
