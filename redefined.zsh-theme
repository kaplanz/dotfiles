#
#  redefined.zsh-theme
#  My zsh theme.
#
#  Created by Zakhary Kaplan on 2019-05-13.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# Colour vars
eval Grey='$FG[008]'
eval DeepSkyBlue2='$FG[031]'
eval SeaGreen3='$FG[078]'
eval MediumPurple1='$FG[141]'
eval Orange1='$FG[214]'

# Primary prompt
PROMPT='$DeepSkyBlue2%~$(git_prompt_info) $MediumPurple1%(!.#.»)%{$reset_color%} '

# Right prompt
RPROMPT='${Grey}${SSH_TTY:+[%n@%m]}[%D{%X}][%D{%x}]%{$reset_color%}'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$DeepSkyBlue2($SeaGreen3"
ZSH_THEME_GIT_PROMPT_SUFFIX="$DeepSkyBlue2)%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$Orange1*"

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
