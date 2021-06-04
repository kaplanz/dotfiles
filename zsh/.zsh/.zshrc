#
#  .zshrc
#  Zsh run commands.
#
#  Created by Zakhary Kaplan on 2021-05-12.
#  Copyright © 2021 Zakhary Kaplan. All rights reserved.
#

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

# -- Before -- {{{
# Source "before" plugins.
ZSH_PLUGINS_BEFORE=("$ZDOTDIR/before"/**/*.zsh(N))
for plugin in $ZSH_PLUGINS_BEFORE; do
    source "$plugin"
    unset plugin
done
# }}}

# -- Completion -- {{{
# The following lines were added by compinstall.
zstyle :compinstall filename '$HOME/.zsh/.zshrc'

autoload -Uz compinit
compinit
# }}}

# -- History -- {{{
# (1) Number of lines of history kept within the shell.
HISTSIZE=10000
# (2) File where history is saved.
HISTFILE="$ZDOTDIR/.zsh_history"
# (3) Number of lines of history to save to $HISTFILE.
SAVEHIST=10000

# Record timestamp of command in HISTFILE
setopt extended_history
# Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_expire_dups_first
# Ignore duplicated commands history list
setopt hist_ignore_dups
# Ignore commands that start with space
setopt hist_ignore_space
# Show command with history expansion to user before running it
setopt hist_verify
# Share command history data
setopt share_history
# }}}

# -- Editing -- {{{
# The keys in the shell's line editor can be made to behave either
# like Emacs or like Vi, two common Unix editors.  If you have no
# experience of either, Emacs is recommended.  If you don't pick one,
# the shell will try to guess based on the EDITOR environment variable.
# Usually it's better to pick one explicitly.
#   -e, for Emacs keymap (recommended unless you are vi user)
#   -v, for Vi keymap
# Comment not to set a keymap (allow shell to choose).
bindkey -v
# }}}

# -- Exports -- {{{
# EDITOR and VISUAL determine the editor that programs such as less.
# and mail clients invoke when asked to edit a file.
export EDITOR='vi'
export VISUAL='vi'

# PAGER is the default text file viewer for programs such as man.
export PAGER='less'

# These are some handy options for less.
export LESS='-MRi'
# }}}

# -- Options -- {{{
# Change directory given just path.
setopt autocd
# Beep on errors.
setopt beep
# Use additional pattern matching features.
setopt extendedglob
# Perform expansion and substitution in prompts.
setopt promptsubst
# Don't allow `>' redirection to truncate existing files.
setopt noclobber
# Unmatched patterns cause an error.
setopt nomatch
# Immediately report changes in background job status.
setopt notify
# }}}

# -- Path -- {{{
# Local binaries.
export PATH="$HOME/.local/bin:$PATH"
# }}}

# -- Fpath -- {{{
# Functions directory.
fpath=("$ZDOTDIR/functions" $fpath)
# Themes directory.
fpath=("$ZDOTDIR/themes" $fpath)
# }}}

# -- Plugins -- {{{
# Source packs.
ZSH_PACKS=("$ZDOTDIR/pack"/*(N))
for pack in $ZSH_PACKS; do
    local name="$pack:t"
    [ -f "$pack/$name.plugin.zsh" ] && source "$pack/$name.plugin.zsh"
    [ -f "$pack/_$name" ]           && fpath=("$pack" $fpath)
    unset name pack
done

# Source plugins.
ZSH_PLUGINS=("$ZDOTDIR/plugin"/**/*.zsh(N))
for plugin in $ZSH_PLUGINS; do
    source "$plugin"
    unset plugin
done
# }}}

# -- Themes -- {{{
# Initialize the prompt system.
autoload -U promptinit
promptinit

# Set the prompt theme.
prompt redefined
# }}}

# -- Various -- {{{
# Tell run-help where to look for the help files.
export HELPDIR="${HELPDIR:-/usr/local/share/zsh/help}"
(( ${+aliases[run-help]} )) && unalias run-help
autoload -Uz run-help
alias help='run-help'

# By default, give other users read-only access to most new files.
umask 022
# }}}

# -- After -- {{{
# Source "after" plugins.
ZSH_PLUGINS_AFTER=("$ZDOTDIR/after"/**/*.zsh(N))
for plugin in $ZSH_PLUGINS_AFTER; do
    source "$plugin"
    unset plugin
done
# }}}

# vim:fdl=0:fdm=marker:
