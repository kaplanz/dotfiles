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
command_time_block='${command_time:+"%F{$Grey42}%K{$Grey7} $command_time %f%k"}'
conda_env_block='${CONDA_DEFAULT_ENV:+"%F{$DarkOliveGreen3}%K{$Grey7} $CONDA_DEFAULT_ENV "}'
hostname_block='${SSH_TTY:+"%F{$LightSlateGrey}%K{$Grey7} %n@%m "}'
time_block='%F{$Grey58}%K{$Grey19} %D{%X}' # Use ZLE_RPROMPT_INDENT as final whitespace

# Primary prompt
PROMPT='%k%F{$DeepSkyBlue2}%~$(git_prompt_info) %F{$MediumPurple1}%(!.#.»)%f '

# Right prompt
RPROMPT="${command_time_block}${conda_env_block}${hostname_block}${time_block}%E"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{$DeepSkyBlue2}(%F{$SeaGreen3}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{$DeepSkyBlue2})%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{$Orange1}*"

# Calculate command execution time
get_command_time() {
    local stop=$(ruby -e 'puts Time.now.to_f')
    local start=${timestamp:-$stop}
    let local elapsed=$stop-$start
    (( $elapsed > 0 )) && printf "%.2fs" $elapsed
}

# Get the initial command timestamp
preexec() {
    timestamp=$(ruby -e 'puts Time.now.to_f')
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
