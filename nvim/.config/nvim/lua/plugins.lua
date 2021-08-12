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
    'cocopon/iceberg.vim',
    'drewtempelmeyer/palenight.vim',
    'folke/tokyonight.nvim',
    'jacoborus/tender.vim',
    'morhetz/gruvbox',
    'nanotech/jellybeans.vim',
    'wojciechkepka/bogster',
    'xero/sourcerer.vim',
  }
  -- }}}

  -- Completion {{{
  use 'zakharykaplan/vim-parry'        -- automatic pair handling
  use 'zakharykaplan/vim-relatable'    -- tab completion
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
    config = function()
      vim.cmd [[runtime! viml/plugins/tree.vim]]
    end,
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'nvim-telescope/telescope.nvim',   -- fuzzy finder over lists
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
