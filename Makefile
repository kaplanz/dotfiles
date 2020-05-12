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
DOTFILES = $(HOME)/.dotfiles
TERMINFO = $(HOME)/.terminfo
TMUX = $(HOME)/.tmux
VIM = $(HOME)/.vim
ZSH = $(HOME)/.oh-my-zsh

# -- Commands --
BREW := $(notdir $(shell command -v brew 2> /dev/null))
MKDIR = mkdir -p
LN = ln -s
STOW = stow --dir=$(DOTFILES) --target=$(HOME)
TIC = tic
# System dependent
ifeq ($(shell uname),Darwin)
	SED = sed -i ''
else ifeq ($(shell uname),Linux)
	SED = sed -i
endif

# -- Colours --
# Vim
VIM_COLOURS += morhetz/gruvbox
VIM_COLOURS += cocopon/iceberg.vim
VIM_COLOURS += nanotech/jellybeans.vim
VIM_COLOURS += kaicataldo/material.vim
VIM_COLOURS += xero/sourcerer.vim

# -- Plugins --
# tmux
TMUX_PLUGINS += tmux-plugins/tpm # use tpm to manage tmux plugins
# Vim
VIM_PLUGINS += tpope/vim-abolish
VIM_PLUGINS += dense-analysis/ale
VIM_PLUGINS += jiangmiao/auto-pairs
VIM_PLUGINS += yuttie/comfortable-motion.vim
VIM_PLUGINS += tpope/vim-commentary
VIM_PLUGINS += Shougo/deoplete.nvim
VIM_PLUGINS += wsdjeg/vim-fetch
VIM_PLUGINS += tpope/vim-fugitive
VIM_PLUGINS += junegunn/fzf.vim
VIM_PLUGINS += roxma/vim-hug-neovim-rpc
VIM_PLUGINS += itchyny/lightline.vim
VIM_PLUGINS += preservim/nerdtree
VIM_PLUGINS += zakharykaplan/vim-relatable
VIM_PLUGINS += tpope/vim-repeat
VIM_PLUGINS += tpope/vim-sleuth
VIM_PLUGINS += tpope/vim-surround
VIM_PLUGINS += majutsushi/tagbar
VIM_PLUGINS += tpope/vim-unimpaired
VIM_PLUGINS += roxma/nvim-yarp
# Zsh
OH_MY_ZSH_PLUGINS += git docker docker-compose
ZSH_PLUGINS += zsh-users/zsh-autosuggestions
ZSH_PLUGINS += akarzim/zsh-docker-aliases
ZSH_PLUGINS += zsh-users/zsh-syntax-highlighting

# -- Utilities --
FZF_SCRIPTS = $(addprefix $(HOME)/.fzf,.bash .zsh)
TERMINFO_FILES = $(wildcard $(TERMINFO)/*.terminfo)


# --------------------------------
#             Targets
# --------------------------------

# -- Make all programs --
.PHONY: all
all: dirs plug stow utils

.PHONY: local
local: stow-local

.PHONY: tmux
tmux: $(TMUX) plug-tmux stow-tmux

.PHONY: vim
vim: $(VIM) plug-vim stow-vim

.PHONY: zsh
zsh: $(ZSH) plug-zsh stow-zsh


# -- Create all directories --
.PHONY: dirs
dirs: $(TERMINFO) $(TMUX) $(VIM) $(ZSH)


# -- Install all --
.PHONY: install
install: all brew


#  -- Uninstall stowed dotfiles --
.PHONY: uninstall
uninstall:
	@$(STOW) -v --delete local
	@$(STOW) -v --delete shell
	@$(STOW) -v --delete tmux
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
stow: stow-local stow-shell stow-tmux stow-vim stow-zsh

.PHONY: stow-local
stow-local:
	$(STOW) --restow local

.PHONY: stow-shell
stow-shell:
	$(STOW) --restow shell

.PHONY: stow-tmux
stow-tmux: $(TMUX)
	$(STOW) --restow tmux

.PHONY: stow-vim
stow-vim: $(VIM)
	$(STOW) --restow vim

.PHONY: stow-zsh
stow-zsh: $(ZSH) stow-shell
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
	$(if $(wildcard $(PLUGIN)),,git clone https://github.com/$@.git $(PLUGIN))

# Vim
.PHONY: plug-vim
plug-vim: $(VIM) $(VIM_COLOURS) $(VIM_PLUGINS)

.PHONY: $(VIM)
$(VIM):
	@bash -c "$(MKDIR) $(VIM)/{colors,ftplugin,pack/{colors,plugins}/start,plugin,swap}"

.PHONY: $(VIM_COLOURS)
$(VIM_COLOURS): REPO = $(VIM)/pack/colors/start/$(patsubst vim-%,%.vim,$(notdir $@))
$(VIM_COLOURS): COLOUR = $(VIM)/colors/$(basename $(notdir $(REPO))).vim
$(VIM_COLOURS): $(VIM)
	$(if $(wildcard $(REPO)),,git clone https://github.com/$@.git $(REPO))
	$(if $(wildcard $(COLOUR)),,$(LN) $(REPO)/colors/$(notdir $(COLOUR)) $(COLOUR))

.PHONY: $(VIM_PLUGINS)
$(VIM_PLUGINS): PLUGIN = $(VIM)/pack/plugins/start/$(patsubst vim-%,%.vim,$(patsubst nvim-%,%.nvim,$(notdir $@)))
$(VIM_PLUGINS): $(VIM)
	$(if $(wildcard $(PLUGIN)),,git clone https://github.com/$@.git $(PLUGIN))

# Zsh
.PHONY: plug-zsh
plug-zsh: PLUGINS = $(OH_MY_ZSH_PLUGINS) $(notdir $(ZSH_PLUGINS))
plug-zsh: $(ZSH) $(ZSH_PLUGINS)
	@$(SED) 's/ZSH_THEME=".*"/ZSH_THEME="redefined"/' ~/.zshrc
	@$(SED) "s/^plugins=(.*)$$/plugins=($(PLUGINS))/" ~/.zshrc

$(ZSH): # use `oh-my-zsh` as base directory
	@sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sed 's/exec zsh -l//')"

.PHONY: $(ZSH_PLUGINS)
$(ZSH_PLUGINS): PLUGIN = $(ZSH)/custom/plugins/$(notdir $@)
$(ZSH_PLUGINS): $(ZSH)
	$(if $(wildcard $(PLUGIN)),,git clone https://github.com/$@.git $(PLUGIN))


# -- Configure utilities --
.PHONY: utils
utils: fzf terminfo

# fzf
.PHONY: fzf
fzf: $(FZF_SCRIPTS)

$(FZF_SCRIPTS):
ifdef BREW
	$$($(BREW) --prefix)/opt/fzf/install --all
endif

# terminfo
.PHONY: terminfo
terminfo: $(TERMINFO) $(TERMINFO_FILES)

.PHONY: $(TERMINFO)
$(TERMINFO):
	@bash -c "$(MKDIR) $(TERMINFO)"

$(TERMINFO)/%.terminfo: $(TERMINFO)
	@$(TIC) -o $(TERMINFO) $@
