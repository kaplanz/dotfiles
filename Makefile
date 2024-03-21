# File:        Makefile
# Author:      Zakhary Kaplan <https://zakhary.dev>
# Created:     23 Feb 2020
# SPDX-License-Identifier: MIT
# Vim:         set fdl=0 fdm=marker:

# ----------------
# -- Variables  --
# ----------------

# {{{
# -- Directories -- {{{
# XDG
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME   ?= $(HOME)/.local/share
# Home
CRON      = $(HOME)/.cron
DOTS      = $(HOME)/.dots
FZF       = $(XDG_DATA_HOME)/fzf
NVIM      = $(XDG_CONFIG_HOME)/nvim
PACKER    = $(XDG_DATA_HOME)/nvim/site/pack/packer
TMUX      = $(XDG_CONFIG_HOME)/tmux
ZPACK     = $(ZSH)/pack
ZPLUG     = $(ZSH)/before
ZSH       = $(XDG_CONFIG_HOME)/zsh
# }}}

# -- Files -- {{{
BREWFILE     = $(DOTS)/Brewfile
# }}}

# -- Commands -- {{{
CLONE  = git clone --depth 1
LN     = ln -sf
MKDIR  = mkdir -p
STOW   = stow --no-folding --dir=$(DOTS) --target=$(HOME)
# Optional
BREW := $(notdir $(shell command -v brew 2> /dev/null))
# }}}

# -- URLs -- {{{
GITHUB = https://github.com
# }}}

# -- Plugins -- {{{
# tmux
TMUX_PLUGINS += tmux-plugins/tpm # use tpm to manage tmux plugins
# Zsh
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
# }}}

# -- Utilities -- {{{
FZF_CONFIG = $(HOME)/.config/fzf/fzf.zsh
# }}}
# }}}


# ----------------
# --  Targets   --
# ----------------

# {{{
# -- Top-level Goals -- {{{
.PHONY: all
all: apps
# }}}

# -- Application Goals -- {{{
.PHONY: apps
apps: etc local nvim tmux zsh

.PHONY: etc
etc: fzf

.PHONY: local
local: stow-local

.PHONY: nvim
nvim: $(NVIM) plug-nvim stow

.PHONY: tmux
tmux: $(TMUX) plug-tmux stow

.PHONY: zsh
zsh: $(ZSH) plug-zsh stow
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
	$(BREW) bundle --file=$(BREWFILE)
endif
# }}}

# -- Stow Goals -- {{{
.PHONY: stow
stow: stow-local
	$(STOW) --restow home

.PHONY: stow-local
stow-local:
	$(STOW) --restow local

.PHONY: unstow
unstow: unstow-local
	@$(STOW) -v --delete home

.PHONY: unstow-local
unstow-local:
	@$(STOW) -v --delete local
# }}}

# -- Plugins Goals -- {{{
.PHONY: plug
plug: plug-nvim plug-tmux plug-zsh

plug-%: stow # always plug after stow

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

# -- Application Goals -- {{{
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

# }}}
# }}}


# ----------------
# --   Extras   --
# ----------------

# {{{
.SECONDARY: # do not remove secondary files

.SUFFIXES: # delete the default suffixes

# Includes
-include ./local/Makefile
# }}}
