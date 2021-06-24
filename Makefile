# File:        Makefile
# Author:      Zakhary Kaplan <https://zakharykaplan.ca>
# Created:     23 Feb 2020
# SPDX-License-Identifier: MIT

# --------------------------------
#            Variables
# --------------------------------

# {{{
# -- Directories -- {{{
CRON      = $(HOME)/.cron
DOTFILES  = $(HOME)/.dotfiles
FZF       = $(HOME)/.local/src/fzf
TERMINFO  = $(HOME)/.terminfo
TMUX      = $(HOME)/.config/tmux
VIM       = $(HOME)/.vim
VIM_PACK  = $(VIM)/pack/plugins/start
VIM_CPACK = $(VIM)/pack/colors/start
ZSH       = $(HOME)/.zsh
ZPACK     = $(ZSH)/pack
ZPLUG     = $(ZSH)/before
# }}}

# -- Commands -- {{{
CLONE = git clone --depth 1
LN    = ln -sf
MKDIR = mkdir -p
STOW  = stow --no-folding --dir=$(DOTFILES) --target=$(HOME)
TIC   = tic
# May not exist
BREW := $(notdir $(shell command -v brew 2> /dev/null))
CURL := $(notdir $(shell command -v curl 2> /dev/null))
# }}}

# -- URLs -- {{{
GITHUB = https://github.com
# }}}

# -- Colours -- {{{
# Vim
VIM_COLOURS += cocopon/iceberg.vim
VIM_COLOURS += drewtempelmeyer/palenight.vim
VIM_COLOURS += jacoborus/tender.vim
VIM_COLOURS += morhetz/gruvbox
VIM_COLOURS += nanotech/jellybeans.vim
VIM_COLOURS += wojciechkepka/bogster
VIM_COLOURS += xero/sourcerer.vim
# }}}

# -- Plugins -- {{{
# tmux
TMUX_PLUGINS += tmux-plugins/tpm # use tpm to manage tmux plugins
# Vim
VIM_COC      = $(VIM_PACK)/coc.nvim
VIM_PLUGINS += AndrewRadev/linediff.vim
VIM_PLUGINS += AndrewRadev/sideways.vim
VIM_PLUGINS += AndrewRadev/switch.vim
VIM_PLUGINS += Yggdroot/indentLine
VIM_PLUGINS += airblade/vim-gitgutter
VIM_PLUGINS += honza/vim-snippets
VIM_PLUGINS += itchyny/lightline.vim
VIM_PLUGINS += junegunn/fzf.vim
VIM_PLUGINS += junegunn/goyo.vim
VIM_PLUGINS += junegunn/limelight.vim
VIM_PLUGINS += junegunn/vim-peekaboo
VIM_PLUGINS += ludovicchabant/vim-gutentags
VIM_PLUGINS += machakann/vim-sandwich
VIM_PLUGINS += mg979/vim-visual-multi
VIM_PLUGINS += preservim/nerdtree
VIM_PLUGINS += preservim/tagbar
VIM_PLUGINS += simnalamburt/vim-mundo
VIM_PLUGINS += tpope/vim-abolish
VIM_PLUGINS += tpope/vim-commentary
VIM_PLUGINS += tpope/vim-eunuch
VIM_PLUGINS += tpope/vim-fugitive
VIM_PLUGINS += tpope/vim-repeat
VIM_PLUGINS += tpope/vim-sleuth
VIM_PLUGINS += tpope/vim-speeddating
VIM_PLUGINS += tpope/vim-unimpaired
VIM_PLUGINS += wellle/targets.vim
VIM_PLUGINS += wsdjeg/vim-fetch
VIM_PLUGINS += zakharykaplan/vim-parry
VIM_PLUGINS += zakharykaplan/vim-relatable
VIM_PLUGINS += zakharykaplan/vim-trailblazer
# Zsh
ZSH_PLUGINS += akarzim/zsh-docker-aliases
ZSH_PLUGINS += zsh-users/zsh-autosuggestions
ZSH_PLUGINS += zsh-users/zsh-syntax-highlighting
# Oh My Zsh
OHMYZSH       = $(ZPACK)/ohmyzsh
OMZ_REPO      = ohmyzsh/ohmyzsh
ZSH_PLUGINS  += $(OMZ_REPO)
OMZ_LIB       = $(OHMYZSH)/lib
OMZ_LIBS     += $(ZPLUG)/completion.zsh
OMZ_LIBS     += $(ZPLUG)/git.zsh
OMZ_LIBS     += $(ZPLUG)/key-bindings.zsh
OMZ_PLUG      = $(OHMYZSH)/plugins
OMZ_PLUGINS  += $(ZPACK)/docker
OMZ_PLUGINS  += $(ZPACK)/git
# }}}

# -- Utilities -- {{{
FZF_CONFIG     = $(HOME)/.config/fzf/fzf.zsh
TERMINFO_FILES = $(wildcard etc/.terminfo/*.terminfo)
# }}}
# }}}


# --------------------------------
#             Targets
# --------------------------------

# {{{
# -- Make all programs -- {{{
.PHONY: all
all: dirs etc local plug stow

.PHONY: local
local: stow-local

.PHONY: tmux
tmux: $(TMUX) plug-tmux stow-tmux

.PHONY: vim
vim: $(VIM) plug-vim stow-vim

.PHONY: zsh
zsh: $(ZSH) plug-zsh stow-zsh
# }}}

# -- Create all directories -- {{{
.PHONY: dirs
dirs: $(CRON) $(TERMINFO) $(TMUX) $(VIM) $(ZSH)
# }}}

# -- Install all -- {{{
.PHONY: install
install: brew all
# }}}

#  -- Uninstall stowed dotfiles -- {{{
.PHONY: uninstall
uninstall: unstow
# }}}

# -- Install Brewfile dependencies -- {{{
.PHONY: brew
brew:
ifdef BREW
	$(BREW) bundle --file=$(DOTFILES)/tools/Brewfile
endif
# }}}

# -- Stow dotfiles -- {{{
.PHONY: stow
stow: stow-etc stow-local stow-tmux stow-vim stow-zsh

.PHONY: stow-etc
stow-etc:
	$(STOW) --restow etc

.PHONY: stow-local
stow-local:
	$(STOW) --restow local

.PHONY: stow-tmux
stow-tmux: $(TMUX)
	$(STOW) --restow tmux

.PHONY: stow-vim
stow-vim: $(VIM)
	$(STOW) --restow vim

.PHONY: stow-zsh
stow-zsh: $(ZSH)
	$(STOW) --restow zsh

.PHONY: unstow
unstow:
	@$(STOW) -v --delete etc
	@$(STOW) -v --delete local
	@$(STOW) -v --delete tmux
	@$(STOW) -v --delete vim
	@$(STOW) -v --delete zsh
# }}}

# -- Install plugins -- {{{
.PHONY: plug
plug: plug-tmux plug-vim plug-zsh

# tmux
.PHONY: plug-tmux
plug-tmux: $(TMUX) $(TMUX_PLUGINS)

.PHONY: $(TMUX)
$(TMUX):
	@bash -c "$(MKDIR) $(TMUX)/{plugins,themes}"

.PHONY: $(TMUX_PLUGINS)
$(TMUX_PLUGINS): PLUGIN = $(TMUX)/plugins/$(notdir $@)
$(TMUX_PLUGINS): $(TMUX)
	$(if $(wildcard $(PLUGIN)),,$(CLONE) $(GITHUB)/$@.git $(PLUGIN))

# Vim
.PHONY: plug-vim
plug-vim: $(VIM) $(VIM_COC) $(VIM_COLOURS) $(VIM_PLUGINS)

.PHONY: $(VIM)
$(VIM):
	@bash -c "$(MKDIR) $(VIM)/{after,pack,plugin,swap,undo}"

$(VIM_COC): | $(VIM)
	git clone $(GITHUB)/neoclide/coc.nvim.git $(VIM_COC)
	cd $(VIM_COC); git checkout release

.PHONY: $(VIM_COLOURS)
$(VIM_COLOURS): REPO = $(VIM_CPACK)/$(patsubst vim-%,%.vim,$(notdir $@))
$(VIM_COLOURS): $(VIM)
	$(if $(wildcard $(REPO)),,$(CLONE) $(GITHUB)/$@.git $(REPO))

.PHONY: $(VIM_PLUGINS)
$(VIM_PLUGINS): REPO = $(VIM_PACK)/$(patsubst vim-%,%.vim,$(patsubst nvim-%,%.nvim,$(notdir $@)))
$(VIM_PLUGINS): $(VIM)
	$(if $(wildcard $(REPO)),,$(CLONE) $(GITHUB)/$@.git $(REPO))

# Zsh
.PHONY: plug-zsh
plug-zsh: $(ZSH) $(ZSH_PLUGINS) $(OHMYZSH)

.PHONY: $(ZSH)
$(ZSH):
	@bash -c "$(MKDIR) $(ZSH)/{after,before,functions,pack,plugin,themes}"

.PHONY: $(ZSH_PLUGINS)
$(ZSH_PLUGINS): PLUGIN = $(ZSH)/pack/$(notdir $@)
$(ZSH_PLUGINS): $(ZSH)
	$(if $(wildcard $(PLUGIN)),,$(CLONE) $(GITHUB)/$@.git $(PLUGIN))

# Oh My Zsh
.PHONY: $(OHMYZSH)
$(OHMYZSH): $(OMZ_REPO) $(OMZ_LIBS) $(OMZ_PLUGINS)

$(OMZ_LIBS): $(ZPLUG)/%: $(OMZ_LIB)/%
	$(MKDIR) $(@D)
	$(LN) $< $@

$(OMZ_PLUGINS): $(ZPACK)/%: $(OMZ_PLUG)/%
	$(MKDIR) $(@D)
	$(LN) $< $@

$(OHMYZSH)/%: $(OMZ_REPO) ;
# }}}

# -- Configure utilities -- {{{
.PHONY: etc
etc: cron fzf terminfo

# cron
.PHONY: cron
cron: $(CRON) stow-etc

$(CRON):
	@bash -c "$(MKDIR) $(CRON)/{locks,logs,scripts}"

# fzf
ifdef BREW
FZF     = $(shell $(BREW) --prefix fzf)
endif
FZF_VIM = $(VIM_PACK)/fzf

.PHONY: fzf
fzf: $(FZF) $(FZF_CONFIG) $(FZF_VIM)

$(FZF): # if not using brew, install fzf using git
ifndef BREW
	$(CLONE) $(GITHUB)/junegunn/fzf.git $(FZF)
endif

$(FZF_CONFIG): INSTALL = $(FZF)/install
$(FZF_CONFIG): FLAGS = --all --xdg --no-update-rc --no-bash
$(FZF_CONFIG): | $(FZF)
	$(INSTALL) $(FLAGS)

$(FZF_VIM): $(FZF) | $(VIM)
	$(MKDIR) $(@D)
	$(LN) $< $@

# terminfo
.PHONY: terminfo
terminfo: $(TERMINFO) $(TERMINFO_FILES) stow-etc

$(TERMINFO):
	@bash -c "$(MKDIR) $(TERMINFO)"

etc/.terminfo/%.terminfo: $(TERMINFO)
	@$(TIC) -o $(TERMINFO) $@
# }}}
# }}}


# --------------------------------
#              Extras
# --------------------------------

# {{{
.SECONDARY: # do not remove secondary files

.SUFFIXES: # delete the default suffixes

# Includes
-include ./local/Makefile
# }}}

# vim:fdl=0:fdm=marker:
