#
#  Makefile
#  My dotfiles Makefile.
#
#  Created by Zakhary Kaplan on 2020-02-23.
#  Copyright © 2020 Zakhary Kaplan. All rights reserved.
#

# --------------------------------
#            Variables
# --------------------------------

# -- Directories --
CRON=$(HOME)/.cron
DOTFILES = $(HOME)/.dotfiles
FZF = $(HOME)/.fzf
TERMINFO = $(HOME)/.terminfo
TMUX = $(HOME)/.tmux
VIM = $(HOME)/.vim
VIM_PACK = $(VIM)/pack/plugins/start
ZSH = $(HOME)/.oh-my-zsh
ZSHRC = $(HOME)/.zshrc

# -- Commands --
GIT_CLONE = git clone --depth 1
LN = ln -s
MKDIR = mkdir -p
STOW = stow --dir=$(DOTFILES) --target=$(HOME)
TIC = tic
# May not exist
BREW := $(notdir $(shell command -v brew 2> /dev/null))
CURL := $(notdir $(shell command -v curl 2> /dev/null))
WGET := $(notdir $(shell command -v wget 2> /dev/null))
# System dependent
ifeq ($(shell uname),Darwin)
	SED = sed -i ''
else ifeq ($(shell uname),Linux)
	SED = sed -i
endif

# -- URLs --
GITHUB = https://github.com

# -- Colours --
# Vim
VIM_COLOURS += cocopon/iceberg.vim
VIM_COLOURS += kaicataldo/material.vim
VIM_COLOURS += morhetz/gruvbox
VIM_COLOURS += nanotech/jellybeans.vim
VIM_COLOURS += xero/sourcerer.vim

# -- Plugins --
# tmux
TMUX_PLUGINS += tmux-plugins/tpm # use tpm to manage tmux plugins
# Vim
VIM_COC = $(VIM_PACK)/coc.nvim
VIM_PLUGINS += AndrewRadev/splitjoin.vim
VIM_PLUGINS += AndrewRadev/switch.vim
VIM_PLUGINS += SirVer/ultisnips
VIM_PLUGINS += easymotion/vim-easymotion
VIM_PLUGINS += honza/vim-snippets
VIM_PLUGINS += itchyny/lightline.vim
VIM_PLUGINS += junegunn/fzf.vim
VIM_PLUGINS += junegunn/vim-peekaboo
VIM_PLUGINS += mg979/vim-visual-multi
VIM_PLUGINS += preservim/nerdtree
VIM_PLUGINS += preservim/tagbar
VIM_PLUGINS += tpope/vim-abolish
VIM_PLUGINS += tpope/vim-commentary
VIM_PLUGINS += tpope/vim-fugitive
VIM_PLUGINS += tpope/vim-repeat
VIM_PLUGINS += tpope/vim-sleuth
VIM_PLUGINS += tpope/vim-speeddating
VIM_PLUGINS += tpope/vim-surround
VIM_PLUGINS += tpope/vim-unimpaired
VIM_PLUGINS += wellle/targets.vim
VIM_PLUGINS += wsdjeg/vim-fetch
VIM_PLUGINS += zakharykaplan/vim-parry
VIM_PLUGINS += zakharykaplan/vim-relatable
# Zsh
OH_MY_ZSH_PLUGINS += git docker docker-compose
ZSH_PLUGINS += akarzim/zsh-docker-aliases
ZSH_PLUGINS += zsh-users/zsh-autosuggestions
ZSH_PLUGINS += zsh-users/zsh-syntax-highlighting

# -- Utilities --
FZF_SCRIPTS = $(addprefix $(FZF),.bash .zsh)
TERMINFO_FILES = $(wildcard utils/.terminfo/*.terminfo)


# --------------------------------
#             Targets
# --------------------------------

# -- Make all programs --
.PHONY: all
all: dirs local plug stow utils

.PHONY: local
local: stow-local

.PHONY: tmux
tmux: $(TMUX) plug-tmux stow-tmux

.PHONY: vim
vim: $(VIM) plug-vim stow-vim

.PHONY: zsh
zsh: $(ZSH) $(ZSHRC) plug-zsh stow-zsh


# -- Create all directories --
.PHONY: dirs
dirs: $(CRON) $(TERMINFO) $(TMUX) $(VIM) $(ZSH)


# -- Install all --
.PHONY: install
install: brew all


#  -- Uninstall stowed dotfiles --
.PHONY: uninstall
uninstall:
	@$(STOW) -v --delete local
	@$(STOW) -v --delete tmux
	@$(STOW) -v --delete utils
	@$(STOW) -v --delete vim
	@$(STOW) -v --delete zsh


# -- Install Brewfile dependencies --
.PHONY: brew
brew:
ifdef BREW
	$(BREW) bundle --file=$(DOTFILES)/tools/Brewfile
endif


# -- Stow dotfiles --
.PHONY: stow
stow: stow-local stow-tmux stow-utils stow-vim stow-zsh

.PHONY: stow-local
stow-local:
	$(STOW) --restow local

.PHONY: stow-tmux
stow-tmux: $(TMUX)
	$(STOW) --restow tmux

.PHONY: stow-utils
stow-utils:
	$(STOW) --restow utils

.PHONY: stow-vim
stow-vim: $(VIM)
	$(STOW) --restow vim

.PHONY: stow-zsh
stow-zsh: $(ZSH)
	$(STOW) --restow zsh


# -- Install plugins --
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
	$(if $(wildcard $(PLUGIN)),,$(GIT_CLONE) $(GITHUB)/$@.git $(PLUGIN))

# Vim
.PHONY: plug-vim
plug-vim: $(VIM) $(VIM_COLOURS) $(VIM_COC) $(VIM_PLUGINS)
	@vim -c 'helptags ALL' -c 'q'

.PHONY: $(VIM)
$(VIM):
	@bash -c "$(MKDIR) $(VIM)/{after,colors,ftplugin,pack,plugin,swap}"

.PHONY: $(VIM_COLOURS)
$(VIM_COLOURS): REPO = $(VIM)/pack/colors/start/$(patsubst vim-%,%.vim,$(notdir $@))
$(VIM_COLOURS): COLOUR = $(VIM)/colors/$(basename $(notdir $(REPO))).vim
$(VIM_COLOURS): $(VIM)
	$(if $(wildcard $(REPO)),,$(GIT_CLONE) $(GITHUB)/$@.git $(REPO))
	$(if $(wildcard $(COLOUR)),,$(LN) $(REPO)/colors/$(notdir $(COLOUR)) $(COLOUR))

.PHONY: $(VIM_PLUGINS)
$(VIM_PLUGINS): PLUGIN = $(VIM_PACK)/$(patsubst vim-%,%.vim,$(patsubst nvim-%,%.nvim,$(notdir $@)))
$(VIM_PLUGINS): $(VIM)
	$(if $(wildcard $(PLUGIN)),,$(GIT_CLONE) $(GITHUB)/$@.git $(PLUGIN))

$(VIM_COC): | $(VIM)
	git clone $(GITHUB)/neoclide/coc.nvim.git $(VIM_COC)
	cd $(VIM_COC); git checkout release

# Zsh
.PHONY: plug-zsh
plug-zsh: PLUGINS = $(OH_MY_ZSH_PLUGINS) $(notdir $(ZSH_PLUGINS))
plug-zsh: $(ZSH) $(ZSHRC) $(ZSH_PLUGINS)
	@$(SED) 's/ZSH_THEME=".*"/ZSH_THEME="redefined"/' $(ZSHRC)
	@$(SED) 's/^plugins=(.*)$$/plugins=($(PLUGINS))/' $(ZSHRC)
	@$(SED) 's/^\(# \)\(DISABLE_UPDATE_PROMPT="true"\)/\2/' $(ZSHRC)

.PHONY: $(ZSH)
$(ZSH): $(ZSH)/.git
$(ZSH)/.git: # use oh-my-zsh as base directory
ifdef CURL
	@sh -c "$$($(CURL) -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sed 's/exec zsh -l//')"
else ifdef WGET
	@sh -c "$$($(WGET) -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sed 's/exec zsh -l//')"
endif

$(ZSHRC): | $(ZSH)
	cp $(ZSH)/templates/zshrc.zsh-template $(ZSHRC)

.PHONY: $(ZSH_PLUGINS)
$(ZSH_PLUGINS): PLUGIN = $(ZSH)/custom/plugins/$(notdir $@)
$(ZSH_PLUGINS): $(ZSH)
	$(if $(wildcard $(PLUGIN)),,$(GIT_CLONE) $(GITHUB)/$@.git $(PLUGIN))


# -- Configure utilities --
.PHONY: utils
utils: cron fzf terminfo

# cron
.PHONY: cron
cron: $(CRON) stow-utils

.PHONY: $(CRON)
$(CRON):
	@bash -c "$(MKDIR) $(CRON)/{locks,logs,scripts}"

# fzf
.PHONY: fzf
fzf: $(FZF) $(FZF_SCRIPTS)

.PHONY: $(FZF)
$(FZF): $(FZF)/.git
$(FZF)/.git: # if not using brew, install fzf using git
ifndef BREW
	$(GIT_CLONE) $(GITHUB)/junegunn/fzf.git $(FZF)
endif

$(FZF_SCRIPTS): | $(FZF)
ifdef BREW
	$$($(BREW) --prefix)/opt/fzf/install --all
else
	$(FZF)/install --all
endif

# terminfo
.PHONY: terminfo
terminfo: $(TERMINFO) $(TERMINFO_FILES)

.PHONY: $(TERMINFO)
$(TERMINFO):
	@bash -c "$(MKDIR) $(TERMINFO)"

utils/.terminfo/%.terminfo: $(TERMINFO) stow-utils
	@$(TIC) -o $(TERMINFO) $@


# --------------------------------
#             Includes
# --------------------------------

-include ./local/Makefile
