#
#  highlight.zsh
#  Zsh highlight plugin.
#
#  Created by Zakhary Kaplan on 2021-05-19.
#  Copyright © 2021 Zakhary Kaplan. All rights reserved.
#

# Define syntax highlighting colurs.
red="$ZSH_PROMPT_COLOUR_RED"
green="$ZSH_PROMPT_COLOUR_GREEN"
yellow="$ZSH_PROMPT_COLOUR_YELLOW"
blue="$ZSH_PROMPT_COLOUR_BLUE"
magenta="$ZSH_PROMPT_COLOUR_MAGENTA"
cyan="$ZSH_PROMPT_COLOUR_CYAN"

# Define syntax highlighting styles.
ZSH_HIGHLIGHT_STYLES[default]="none"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=$red,bold"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=$yellow"
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=$green,underline"
ZSH_HIGHLIGHT_STYLES[global-alias]="fg=$cyan"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=$green,underline"
ZSH_HIGHLIGHT_STYLES[commandseparator]="none"
ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=$green,underline"
ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
ZSH_HIGHLIGHT_STYLES[globbing]="fg=$blue"
ZSH_HIGHLIGHT_STYLES[history-expansion]="fg=$blue"
ZSH_HIGHLIGHT_STYLES[command-substitution]="none"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]="fg=$magenta"
ZSH_HIGHLIGHT_STYLES[process-substitution]="none"
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]="fg=$magenta"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="none"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="none"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="none"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]="fg=$magenta"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$yellow"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$yellow"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=$yellow"
ZSH_HIGHLIGHT_STYLES[rc-quote]="fg=$cyan"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=$cyan"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=$cyan"
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=$cyan"
ZSH_HIGHLIGHT_STYLES[assign]="none"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=$yellow"
ZSH_HIGHLIGHT_STYLES[comment]="fg=black,bold"
ZSH_HIGHLIGHT_STYLES[named-fd]="none"
ZSH_HIGHLIGHT_STYLES[numeric-fd]="none"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=$green"

# Unset syntax highlighting colurs.
unset red
unset green
unset yellow
unset blue
unset magenta
unset cyan
