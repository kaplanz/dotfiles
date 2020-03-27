#
#  Makefile
#  My dotfiles Makefile.
#
#  Created by Zakhary Kaplan on 2020-02-23.
#  Copyright © 2020 Zakhary Kaplan. All rights reserved.
#

# -- Directories --
DOTFILES = $(HOME)/.dotfiles
TMUX = $(HOME)/.tmux
VIM = $(HOME)/.vim
ZSH = $(HOME)/.oh-my-zsh


# -- Commands --
BREW := $(notdir $(shell command -v brew 2> /dev/null))
MKDIR = mkdir -p
STOW = stow --dir=$(DOTFILES) --target=$(HOME)
ifeq ($(shell uname),Darwin)
	SED = sed -i ''
else ifeq ($(shell uname),Linux)
	SED = sed -i
endif


# -- Plugins --
# tmux
TMUX_PLUGINS += tmux-plugins/tpm # use tpm to manage tmux plugins

# Vim
VIM_COLOURS += https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
VIM_PLUGINS += dense-analysis/ale
VIM_PLUGINS += yuttie/comfortable-motion.vim
VIM_PLUGINS += tpope/vim-commentary
VIM_PLUGINS += Shougo/deoplete.nvim
VIM_PLUGINS += tpope/vim-fugitive
VIM_PLUGINS += junegunn/fzf.vim
VIM_PLUGINS += roxma/vim-hug-neovim-rpc
VIM_PLUGINS += itchyny/lightline.vim
VIM_PLUGINS += scrooloose/nerdtree
VIM_PLUGINS += tpope/vim-repeat
VIM_PLUGINS += justinmk/vim-sneak
VIM_PLUGINS += tpope/vim-surround
VIM_PLUGINS += tpope/vim-unimpaired
VIM_PLUGINS += roxma/nvim-yarp

# Zsh
OH_MY_ZSH_PLUGINS += git
ZSH_PLUGINS += zsh-users/zsh-autosuggestions
ZSH_PLUGINS += zsh-users/zsh-syntax-highlighting


# -- Targets --
# Make all programs
.PHONY: all
all: local tmux vim zsh

.PHONY: local
local: stow-local

.PHONY: tmux
tmux: plug-tmux stow-tmux

.PHONY: vim
vim: plug-vim stow-vim

.PHONY: zsh
zsh: plug-zsh stow-zsh


# Install Brewfile dependencies, install plugins, stow dotfiles
.PHONY: install
install: brew plug stow


# Uninstall stowed dotfiles
.PHONY: uninstall
uninstall:
	@$(STOW) -v --delete local
	@$(STOW) -v --delete shell
	@$(STOW) -v --delete tmux
	@$(STOW) -v --delete vim
	@$(STOW) -v --delete zsh


# Install Brewfile dependencies
.PHONY: brew
brew:
ifdef BREW
	$(BREW) bundle --file=$(DOTFILES)/tools/Brewfile
endif


# Stow dotfiles
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


# Install plugins
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
plug-vim: $(VIM) $(VIM_PLUGINS) colours-vim

.PHONY: $(VIM)
$(VIM):
	@bash -c "$(MKDIR) $(VIM)/{colors,ftplugin,pack/plugins/start,plugin,swap}"

.PHONY: $(VIM_PLUGINS)
$(VIM_PLUGINS): PLUGIN = $(VIM)/pack/plugins/start/$(patsubst vim-%,%.vim,$(notdir $@))
$(VIM_PLUGINS): $(VIM)
	$(if $(wildcard $(PLUGIN)),,git clone https://github.com/$@.git $(PLUGIN))

.PHONY: colours-vim
colours-vim: $(VIM)
	$(foreach url,$(VIM_COLOURS),$(if $(wildcard $(VIM)/colors/$(notdir $(url))),,curl -o $(VIM)/colors/$(notdir $(url)) $(url)))

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
