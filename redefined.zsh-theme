#
#  redefined.zsh-theme
#  My zsh theme.
#
#  Created by Zakhary Kaplan on 2019-05-13.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# Colour vars
eval DeepSkyBlue3='$FG[032]'
eval SteelBlue1='$FG[075]'
eval SeaGreen3='$FG[078]'
eval LightSlateBlue='$FG[105]'
eval Orange1='$FG[214]'
eval Grey23='$FG[237]'

# Primary prompt
PROMPT='$SteelBlue1%~$(git_prompt_info) $LightSlateBlue%(!.#.»)%{$reset_color%} '

# Right prompt
RPROMPT='$Grey23%n@%m%{$reset_color%}'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$SteelBlue1($SeaGreen3"
ZSH_THEME_GIT_PROMPT_SUFFIX="$SteelBlue1)%{$reset_color%}"
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
