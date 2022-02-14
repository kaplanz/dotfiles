# File:        Makefile
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     23 Feb 2020
# SPDX-License-Identifier: MIT

# --------------------------------
#            Variables
# --------------------------------

# {{{
# -- Directories -- {{{
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME   ?= $(HOME)/.local/share
CRON      = $(HOME)/.cron
DOTFILES  = $(HOME)/.dotfiles
FZF       = $(XDG_DATA_HOME)/fzf
NVIM      = $(XDG_CONFIG_HOME)/nvim
PACKER    = $(XDG_DATA_HOME)/nvim/site/pack/packer
TERMINFO  = $(HOME)/.terminfo
TMUX      = $(XDG_CONFIG_HOME)/tmux
ZPACK     = $(ZSH)/pack
ZPLUG     = $(ZSH)/before
ZSH       = $(HOME)/.zsh
# }}}

# -- Files -- {{{
TERMINFO.SRC = $(TERMINFO)/terminfo.src
# }}}

# -- Commands -- {{{
CLONE  = git clone --depth 1
GUNZIP = gunzip
LN     = ln -sf
MKDIR  = mkdir -p
STOW   = stow --no-folding --dir=$(DOTFILES) --target=$(HOME)
TIC    = tic
WGET   = wget
# Optional
BREW := $(notdir $(shell command -v brew 2> /dev/null))
# }}}

# -- URLs -- {{{
GITHUB = https://github.com
TERMINFO.SRC.GZ = http://invisible-island.net/datafiles/current/terminfo.src.gz
# }}}

# -- Plugins -- {{{
# tmux
TMUX_PLUGINS += tmux-plugins/tpm # use tpm to manage tmux plugins
# Zsh
ZSH_PLUGINS  += akarzim/zsh-docker-aliases
ZSH_PLUGINS  += zsh-users/zsh-autosuggestions
ZSH_PLUGINS  += zsh-users/zsh-syntax-highlighting
# Zsh: Oh My Zsh
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
FZF_CONFIG = $(HOME)/.config/fzf/fzf.zsh
TERMINFOS  = tmux-256color
# }}}
# }}}


# --------------------------------
#             Targets
# --------------------------------

# {{{
# -- Top-level Goals -- {{{
.PHONY: all
all: apps
# }}}

# -- Application Goals -- {{{
.PHONY: apps
apps: etc local nvim tmux zsh

.PHONY: etc
etc: cron fzf terminfo

.PHONY: local
local: stow-local

.PHONY: nvim
nvim: $(NVIM) plug-nvim stow-nvim

.PHONY: tmux
tmux: $(TMUX) plug-tmux stow-tmux

.PHONY: zsh
zsh: $(ZSH) plug-zsh stow-zsh
# }}}

# -- Install Goals -- {{{
.PHONY: install
install: brew all

.PHONY: uninstall
uninstall: unstow
# }}}

# -- Dependency Goals -- {{{
%: brew

.PHONY: brew
brew:
ifdef BREW
	$(BREW) bundle --file=$(DOTFILES)/tools/Brewfile
endif
# }}}

# -- Stow Goals -- {{{
.PHONY: stow
stow: stow-etc stow-local stow-nvim stow-tmux stow-zsh

.PHONY: stow-etc
stow-etc:
	$(STOW) --restow etc

.PHONY: stow-local
stow-local:
	$(STOW) --restow local

.PHONY: stow-nvim
stow-nvim: $(NVIM)
	$(STOW) --restow nvim

.PHONY: stow-tmux
stow-tmux: $(TMUX)
	$(STOW) --restow tmux

.PHONY: stow-zsh
stow-zsh: $(ZSH)
	$(STOW) --restow zsh

.PHONY: unstow
unstow:
	@$(STOW) -v --delete etc
	@$(STOW) -v --delete local
	@$(STOW) -v --delete tmux
	@$(STOW) -v --delete zsh
# }}}

# -- Plugins Goals -- {{{
.PHONY: plug
plug: plug-nvim plug-tmux plug-zsh

plug-%: stow-% # always plug after stow

# Nvim {{{
.PHONY: plug-nvim
plug-nvim: $(NVIM)

$(NVIM):
	@$(MKDIR) $@

.PHONY: packer
packer: $(NVIM)
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
# }}}

# tmux {{{
.PHONY: plug-tmux
plug-tmux: $(TMUX) $(TMUX_PLUGINS)

.PHONY: $(TMUX)
$(TMUX):
	@bash -c "$(MKDIR) $(TMUX)/{plugins,themes}"

.PHONY: $(TMUX_PLUGINS)
$(TMUX_PLUGINS): PLUGIN = $(TMUX)/plugins/$(notdir $@)
$(TMUX_PLUGINS): $(TMUX)
	$(if $(wildcard $(PLUGIN)),,$(CLONE) $(GITHUB)/$@.git $(PLUGIN))
# }}}

# Zsh {{{
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
# }}}

# -- Utility Goals -- {{{
# cron {{{
.PHONY: cron
cron: $(CRON) stow-etc

.PHONY: $(CRON)
$(CRON):
	@bash -c "$(MKDIR) $(CRON)/{locks,logs,scripts}"
# }}}

# fzf {{{
ifdef BREW
FZF = $(shell $(BREW) --prefix fzf)
endif

.PHONY: fzf
fzf: $(FZF) $(FZF_CONFIG)

$(FZF): # if not using brew, install fzf using git
ifndef BREW
	$(CLONE) $(GITHUB)/junegunn/fzf.git $(FZF)
endif

$(FZF_CONFIG): INSTALL = $(FZF)/install
$(FZF_CONFIG): FLAGS = --all --xdg --no-update-rc --no-bash
$(FZF_CONFIG): | $(FZF)
	$(INSTALL) $(FLAGS)
# }}}

# terminfo
.PHONY: terminfo
terminfo: $(TERMINFO.SRC)

$(TERMINFO.SRC):
	@$(MKDIR) $(@D)
	$(WGET) -P $(@D) $(TERMINFO.SRC.GZ)
	$(GUNZIP) $@.gz
	$(TIC) -xe tmux-256color $@
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
