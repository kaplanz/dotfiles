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

# Take advantage of $LS_COLORS for completion
[[ ! -z "$LS_COLORS" ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Colours
zsh_prompt_arrow='110'
zsh_prompt_blue_fg='31'
zsh_prompt_git='71'
zsh_prompt_git_dirty='215'
zsh_prompt_green_fg='107'
zsh_prompt_magenta_fg='183'
zsh_prompt_main='25'
zsh_prompt_primary_bg='233'
zsh_prompt_primary_fg='242'
zsh_prompt_red_fg='167'
zsh_prompt_secondary_bg='236'
zsh_prompt_secondary_fg='246'
zsh_prompt_yellow_fg='222'

# -- Prompt --
# Prompt blocks
exit_status_block='%(?,,%F{$zsh_prompt_red_fg}%K{$zsh_prompt_primary_bg} $? %f%k)'
command_time_block='${command_time:+"%F{$zsh_prompt_primary_fg}%K{$zsh_prompt_primary_bg} $command_time %f%k"}'
hostname_block='${SSH_TTY:+"%F{$zsh_prompt_blue_fg}%K{$zsh_prompt_primary_bg} %n@%m "}'
time_block='%F{$zsh_prompt_secondary_fg}%K{$zsh_prompt_secondary_bg} %D{%X}' # Use ZLE_RPROMPT_INDENT as final whitespace

# Primary prompt
PROMPT='%k%F{$zsh_prompt_main}%~$(git_prompt_info) %F{$zsh_prompt_arrow}%(!.#.»)%f '

# Right prompt
RPROMPT="${exit_status_block}${command_time_block}${hostname_block}${time_block}%E"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%F{$zsh_prompt_main}(%F{$zsh_prompt_git}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{$zsh_prompt_main})%f"
ZSH_THEME_GIT_PROMPT_CLEAN=''
ZSH_THEME_GIT_PROMPT_DIRTY="%F{$zsh_prompt_git_dirty}*"

# Calculate command execution time
get_command_time() {
    local stop=$EPOCHREALTIME
    local start=${timestamp:-$stop}
    let local elapsed=$stop-$start
    (( $elapsed > 0 )) && printf '%.2fs' $elapsed
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
red=$zsh_prompt_red_fg
green=$zsh_prompt_git
yellow=$zsh_prompt_yellow_fg
blue=$zsh_prompt_main
magenta=$zsh_prompt_magenta_fg
cyan=$zsh_prompt_arrow

# Define styles
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=$red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=$yellow
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=$green,underline
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=$cyan
ZSH_HIGHLIGHT_STYLES[precommand]=fg=$green,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=$green,underline
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
ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
ZSH_HIGHLIGHT_STYLES[named-fd]=none
ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
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
# pure.zsh-theme: <https://github.com/sindresorhus/pure>

# vim:ft=zsh:
