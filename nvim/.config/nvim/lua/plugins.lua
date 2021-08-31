-- File:        plugins.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     05 Aug 2021
-- SPDX-License-Identifier: MIT

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Install packer if not currently installed
require('plugins.packer')

-- Automatically run `:PackerCompile` whenever plugins.lua is updated
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

return require('packer').startup({function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'         -- Neovim plugin manager

  -- Colours {{{
  use {
    'EdenEast/nightfox.nvim',
    'cocopon/iceberg.vim',
    'drewtempelmeyer/palenight.vim',
    'folke/tokyonight.nvim',
    'jacoborus/tender.vim',
    'morhetz/gruvbox',
    'nanotech/jellybeans.vim',
    'sainnhe/everforest',
    'wojciechkepka/bogster',
    'xero/sourcerer.vim',
  }
  -- }}}

  -- Completion {{{
  use {
    'hrsh7th/nvim-cmp',                -- auto completion plugin
    config = function()
      require('plugins.cmp')
    end,
    requires = {
      -- Common
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-calc',
      'f3fora/cmp-spell',
      -- Neovim-specific
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      -- External plugins
      { 'tzachar/cmp-tabnine', run='./install.sh', }
    },
  }
  use {
    'zakharykaplan/vim-parry',         -- automatic pair handling
    event = 'InsertEnter',
  }
  use {
    'zakharykaplan/vim-relatable',     -- tab completion
    event = 'InsertEnter',
  }
  -- }}}

  -- Extensions {{{
  use 'AndrewRadev/switch.vim'         -- switch text segments
  use 'machakann/vim-sandwich'         -- edit sandwiched textobjects
  use {
    'mg979/vim-visual-multi',          -- modal multiple cursors
    config = function()
      vim.cmd [[runtime! viml/plugins/visual-multi.vim]]
    end,
  }
  use 'tpope/vim-abolish'              -- searches, substitutions, and abbreviations
  use 'tpope/vim-commentary'           -- comment stuff out
  use 'tpope/vim-eunuch'               -- UNIX file manipulation
  use 'tpope/vim-repeat'               -- repeat plugin maps
  use 'tpope/vim-speeddating'          -- increment dates, times, and more
  use 'tpope/vim-unimpaired'           -- handy bracket mappings
  use 'wellle/targets.vim'             -- additional text objects
  -- }}}

  -- Git {{{
  use 'airblade/vim-gitgutter'         -- shows a git diff in the gutter
  use 'tpope/vim-fugitive'             -- Git wrapper
  -- }}}

  -- LSP {{{
  use {
    {
      'neovim/nvim-lspconfig',         -- LSP common configurations
      config = function()
        require('plugins.lspconfig')
      end,
    },
    'kabouzeid/nvim-lspinstall',       -- conveniently install language servers
    'onsails/lspkind-nvim',            -- add pictograms to LSP
  }
  -- }}}

  -- Tags {{{
  use {
    'ludovicchabant/vim-gutentags',    -- automatic ctags management
    config = function()
      vim.cmd [[runtime! viml/plugins/gutentags.vim]]
    end,
  }
  -- }}}

  -- Text {{{
  use {
    'lukas-reineke/indent-blankline.nvim', -- show vertical lines for indent
    config = function()
      require('plugins.indent-blankline')
    end,
  }
  use 'tpope/vim-sleuth'               -- heuristically set buffer options
  use 'zakharykaplan/vim-trailblazer'  -- whitespace management
  -- }}}

  -- Treesitter {{{
  use {
    'nvim-treesitter/nvim-treesitter', -- treesitter configurations
    config = function()
      require('plugins.treesitter')
    end,
    run = ':TSUpdate',
  }
  -- }}}

  -- UI {{{
  use {
    'akinsho/nvim-bufferline.lua',     -- snazzy bufferline
    config = function()
      require('plugins.bufferline')
    end,
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'hoob3rt/lualine.nvim',            -- blazing fast statusline
    config = function()
      require('plugins.lualine')
    end,
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    },
  }
  use 'junegunn/vim-peekaboo'          -- peek at the contents of the registers
  use {
    'kyazdani42/nvim-tree.lua',        -- file explorer written in lua
    setup = function()
      vim.cmd [[runtime! viml/plugins/tree.vim]]
    end,
    cmd = 'NvimTreeToggle',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'nvim-telescope/telescope.nvim',   -- fuzzy finder over lists
    cmd = 'Telescope',
    keys = {
      {'n', '<Leader>F'},
      {'n', '<Leader>ff'},
      {'n', '<Leader>fg'},
      {'n', '<Leader>fb'},
      {'n', '<Leader>fh'},
      {'n', '<C-p>'},
    },
    config = function()
      require('plugins.telescope')
    end,
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
  }
  use {
    'preservim/tagbar',                -- display tags of a file
    config = function()
      vim.cmd [[runtime! viml/plugins/tagbar.vim]]
    end,
  }
  -- }}}
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

-- vim:fdl=0:fdm=marker: