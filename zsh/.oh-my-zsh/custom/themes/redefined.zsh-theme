#
#  redefined.zsh-theme
#  af-magic inspired zsh theme.
#
#  Created by Zakhary Kaplan on 2019-05-13.
#  Copyright © 2019 Zakhary Kaplan. All rights reserved.
#

# -- Setup --
# Load zsh modules
zmodload zsh/datetime

# Use jellybeans $LS_COLORS theme
LS_COLORS="$(cat $DOTFILES/utils/jellybeans.ls-colors | tr '\n' ':')"
# Take advantage of $LS_COLORS for completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Colour vars
DeepSkyBlue4='25'
DeepSkyBlue3='31'
DarkSeaGreen4='71'
DarkOliveGreen3='107'
LightSkyBlue3='110'
IndianRed='167'
Plum2='183'
SandyBrown='215'
LightGoldenrod2='222'
Grey7='233'
Grey19='236'
Grey42='242'
Grey58='246'

# -- Prompt --
# Prompt blocks
command_time_block='${command_time:+"%F{$Grey42}%K{$Grey7} $command_time %f%k"}'
conda_env_block='${CONDA_DEFAULT_ENV:+"%F{$DarkOliveGreen3}%K{$Grey7} $CONDA_DEFAULT_ENV "}'
hostname_block='${SSH_TTY:+"%F{$DeepSkyBlue3}%K{$Grey7} %n@%m "}'
time_block='%F{$Grey58}%K{$Grey19} %D{%X}' # Use ZLE_RPROMPT_INDENT as final whitespace

# Primary prompt
PROMPT='%k%F{$DeepSkyBlue4}%~$(git_prompt_info) %F{$LightSkyBlue3}%(!.#.»)%f '

# Right prompt
RPROMPT="${command_time_block}${conda_env_block}${hostname_block}${time_block}%E"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{$DeepSkyBlue4}(%F{$DarkSeaGreen4}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{$DeepSkyBlue4})%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%F{$SandyBrown}*"

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


# -- Syntax Highlighting --
# Set colours
red=$IndianRed
green=$DarkSeaGreen4
yellow=$LightGoldenrod2
blue=$DeepSkyBlue4
magenta=$Plum2
cyan=$LightSkyBlue3

# Define styles
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=$red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=$yellow
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=$green,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=$green,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
ZSH_HIGHLIGHT_STYLES[globbing]=fg=$blue
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=$blue
ZSH_HIGHLIGHT_STYLES[command-substitution]=none
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=$magenta
ZSH_HIGHLIGHT_STYLES[process-substitution]=none
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=$magenta
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=$magenta
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=$yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=$yellow
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=$yellow
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=$cyan
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=$cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=$cyan
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=$cyan
ZSH_HIGHLIGHT_STYLES[assign]=none
ZSH_HIGHLIGHT_STYLES[redirection]=fg=$yellow
ZSH_HIGHLIGHT_STYLES[comment]=fg=$black,bold
ZSH_HIGHLIGHT_STYLES[named-fd]=none
ZSH_HIGHLIGHT_STYLES[arg0]=fg=$green

# Unset colours
unset red
unset green
unset yellow
unset blue
unset magenta
unset cyan


# --------------------------------
#            References
# --------------------------------
#
# af-magic.zsh-theme: <https://github.com/andyfleming/oh-my-zsh>
# pure.zsh-theme: <https://github.com/sindresorhus>
