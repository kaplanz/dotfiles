# File:        highlight.zsh
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     19 May 2021
# SPDX-License-Identifier: MIT

# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -gA HIGHLIGHT
HIGHLIGHT[RED]=167
HIGHLIGHT[GRN]=107
HIGHLIGHT[BLU]=025
HIGHLIGHT[CYN]=110
HIGHLIGHT[MGA]=183
HIGHLIGHT[YLW]=222
HIGHLIGHT[GRY]=246

ZSH_HIGHLIGHT_STYLES[default]="none"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=$HIGHLIGHT[RED],bold"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=$HIGHLIGHT[YLW]"
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=$HIGHLIGHT[GRN],underline"
ZSH_HIGHLIGHT_STYLES[global-alias]="fg=$HIGHLIGHT[CYN]"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=$HIGHLIGHT[GRN],underline"
ZSH_HIGHLIGHT_STYLES[commandseparator]="none"
ZSH_HIGHLIGHT_STYLES[autodirectory]="fg=$HIGHLIGHT[GRN],underline"
ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
ZSH_HIGHLIGHT_STYLES[globbing]="fg=$HIGHLIGHT[BLU]"
ZSH_HIGHLIGHT_STYLES[history-expansion]="fg=$HIGHLIGHT[BLU]"
ZSH_HIGHLIGHT_STYLES[command-substitution]="none"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]="fg=$HIGHLIGHT[MGA]"
ZSH_HIGHLIGHT_STYLES[process-substitution]="none"
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]="fg=$HIGHLIGHT[MGA]"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fd=$HIGHLIGHT[GRY]"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fd=$HIGHLIGHT[GRY]"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="none"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]="fg=$HIGHLIGHT[MGA]"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$HIGHLIGHT[GRY]"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$HIGHLIGHT[GRY]"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=$HIGHLIGHT[YLW]"
ZSH_HIGHLIGHT_STYLES[rc-quote]="fg=$HIGHLIGHT[CYN]"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=$HIGHLIGHT[CYN]"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=$HIGHLIGHT[CYN]"
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]="fg=$HIGHLIGHT[CYN]"
ZSH_HIGHLIGHT_STYLES[assign]="none"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=$HIGHLIGHT[YLW]"
ZSH_HIGHLIGHT_STYLES[comment]="fg=$HIGHLIGHT[GRY],bold"
ZSH_HIGHLIGHT_STYLES[named-fd]="none"
ZSH_HIGHLIGHT_STYLES[numeric-fd]="none"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=$HIGHLIGHT[GRN]"
