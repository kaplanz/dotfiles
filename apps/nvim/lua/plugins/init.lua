-- File:        init.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     05 Aug 2021
-- SPDX-License-Identifier: MIT

-- This file can be loaded by calling `lua require('plugins')` from your init.lua
-- Bootstrap {{{
-- Install packer if not currently installed
local bootstrap
do
  local fn = vim.fn
  local path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(path)) > 0 then
    bootstrap = fn.system({
      'git',
      'clone',
      '--depth=1',
      'https://github.com/wbthomason/packer.nvim',
      path })
    vim.cmd [[packadd packer.nvim]]
  end
end

-- Automatically run `:PackerCompile` whenever this file is updated
vim.cmd [[
  augroup PackerUserConfig
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]]
-- }}}

-- Packer startup
return require('packer').startup(function(use)
  -- Packer can manage itself
  -- Neovim plugin manager
  use 'wbthomason/packer.nvim'

  -- Colours {{{
  use {
    'EdenEast/nightfox.nvim',
    { 'catppuccin/nvim', as = 'catppuccin' },
    'cocopon/iceberg.vim',
    'drewtempelmeyer/palenight.vim',
    'folke/tokyonight.nvim',
    'jacoborus/tender.vim',
    'morhetz/gruvbox',
    'nanotech/jellybeans.vim',
    'sainnhe/everforest',
    'vv9k/bogster',
    'xero/sourcerer.vim',
  }
  -- }}}

  -- Completion {{{
  use {
    -- Auto completion plugin
    'hrsh7th/nvim-cmp',
    config = function()
      require('plugins.cmp')
    end,
    requires = {
      -- Internal Sources
      'f3fora/cmp-spell',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      -- External Sources
      { 'tzachar/cmp-tabnine', run = './install.sh', },
      -- Language Server Protocol
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      -- Extensions
      'dcampos/cmp-snippy',
      'ray-x/cmp-treesitter',
    },
  }
  use {
    -- Super powerful autopairs
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = function()
      require('plugins.nvim-autopairs')
    end,
    event = 'InsertEnter',
  }
  -- }}}

  -- Extensions {{{
  -- Move function arguments
  use 'AndrewRadev/sideways.vim'
  -- Switch text segments
  use 'AndrewRadev/switch.vim'
  -- Create custom submodes and menus
  use {
    'anuvyklack/hydra.nvim',
    config = function()
      require('plugins.hydra')
    end,
  }
  -- Peek at the contents of the registers
  use 'junegunn/vim-peekaboo'
  -- Edit sandwiched textobjects
  use 'machakann/vim-sandwich'
  use {
    -- Modal multiple cursors
    'mg979/vim-visual-multi',
    config = function()
      vim.g.VM_leader = '\\'
    end,
  }
  -- Searches, substitutions, and abbreviations
  use 'tpope/vim-abolish'
  -- Comment stuff out
  use 'tpope/vim-commentary'
  -- Unix file manipulation
  use 'tpope/vim-eunuch'
  -- Repeat plugin maps
  use 'tpope/vim-repeat'
  -- Increment dates, times, and more
  use 'tpope/vim-speeddating'
  -- Handy bracket mappings
  use 'tpope/vim-unimpaired'
  -- Additional text objects
  use 'wellle/targets.vim'
  -- }}}

  -- Formatting: {{{
  use {
    -- Format runner
    'mhartington/formatter.nvim',
    config = function()
      require('plugins.formatter')
    end
  }
  -- }}}

  -- Git {{{
  use {
    -- Git integration for buffers
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.gitsigns')
    end,
    requires = 'nvim-lua/plenary.nvim',
  }
  -- Git wrapper
  use 'tpope/vim-fugitive'
  -- }}}

  -- LSP {{{
  use {
    -- Ui for nvim-lsp progress
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
  }
  use {
    {
      -- Lsp common configurations
      'neovim/nvim-lspconfig',
      config = function()
        require('plugins.lspconfig')
      end,
    },
    -- Seamlessly install LSP servers
    'williamboman/nvim-lsp-installer',
    -- Add pictograms to LSP
    'onsails/lspkind-nvim',
  }
  -- }}}

  -- Snippets: {{{
  use {
    -- Snippet engine
    'dcampos/nvim-snippy',
    config = function()
      require('plugins.snippy')
    end,
    requires = 'honza/vim-snippets',
  }
  -- }}}

  -- Tags {{{
  use {
    -- Automatic ctags management
    'ludovicchabant/vim-gutentags',
    config = function()
      vim.g.gutentags_enabled = vim.fn.filereadable('tags')
      vim.g.gutentags_define_advanced_commands = true
    end,
  }
  -- }}}

  -- Text {{{
  use {
    -- Show vertical lines for indent
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.indent-blankline')
    end,
  }
  -- Heuristically set buffer options
  use 'tpope/vim-sleuth'
  -- Whitespace management
  use 'zakharykaplan/vim-trailblazer'
  -- }}}

  -- Treesitter {{{
  use {
    -- Treesitter configurations
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('plugins.nvim-treesitter')
    end,
    run = ':TSUpdate',
  }
  -- Show code context
  use 'nvim-treesitter/nvim-treesitter-context'
  -- }}}

  -- User Interface {{{
  use {
    -- Snazzy bufferline
    'akinsho/bufferline.nvim',
    config = function()
      require('plugins.bufferline')
    end,
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    -- Ultra fold in Neovim
    'kevinhwang91/nvim-ufo',
    config = function()
      require('ufo').setup {
        open_fold_hl_timeout = 0,
      }
    end,
    requires = 'kevinhwang91/promise-async'
  }
  use {
    -- Blazing fast statusline
    'nvim-lualine/lualine.nvim',
    config = function()
      require('plugins.lualine')
    end,
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    },
  }
  use {
    -- File explorer written in lua
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('plugins.nvim-tree')
    end,
    cmd = 'NvimTreeToggle',
    keys = {
      { 'n', '<Leader>n' },
      { 'n', '<Leader>N' },
    },
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    -- Fuzzy finder over lists
    'nvim-telescope/telescope.nvim',
    config = function()
      require('plugins.telescope')
    end,
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
  }
  -- Improve the default vim.ui interfaces
  use 'stevearc/dressing.nvim'
  -- }}}

  -- Automatically set up your configuration after cloning packer.nvim
  -- (Put this at the end after all plugins)
  if bootstrap then
    require('packer').sync()
  end
end)

-- vim:fdl=0:fdm=marker:
