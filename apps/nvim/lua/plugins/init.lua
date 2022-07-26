-- File:        init.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     05 Aug 2021
-- SPDX-License-Identifier: MIT

-- This file can be loaded by calling `lua require("plugins")` from your init.lua
-- Bootstrap {{{
-- Install packer if not currently installed
local bootstrap
do
  local fn = vim.fn
  local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(path)) > 0 then
    bootstrap = fn.system({
      "git",
      "clone",
      "--depth=1",
      "https://github.com/wbthomason/packer.nvim",
      path
    })
    vim.cmd [[packadd packer.nvim]]
  end
end

-- Automatically run `:PackerCompile` whenever this file is updated
vim.cmd [[
  augroup Plugins
    autocmd!
    autocmd BufWritePost lua/**/*.lua source <afile> | PackerCompile
  augroup end
]]
-- }}}

-- Packer startup
return require("packer").startup(function(use)
  -- Packer can manage itself
  -- Neovim plugin manager
  use "wbthomason/packer.nvim"

  -- Colours {{{
  use {
    "EdenEast/nightfox.nvim",
    "rebelot/kanagawa.nvim",
    "sainnhe/everforest",
    "xero/sourcerer.vim",
  }
  -- }}}

  -- Completion {{{
  use {
    -- Auto completion plugin
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp")
    end,
    requires = {
      -- Vim-builtin
      "f3fora/cmp-spell",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-omni",
      -- Neovim-builtin
      "hrsh7th/cmp-nvim-lua",
      "ray-x/cmp-treesitter",
      -- Snippets
      "dcampos/cmp-snippy",
      -- Language Server Protocol
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- Filesystem
      "hrsh7th/cmp-path",
      "lukas-reineke/cmp-rg",
      -- Extensions
      "hrsh7th/cmp-cmdline",
    },
  }
  use {
    -- Super powerful autopairs
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("nvim-autopairs").setup {}

      -- Interoperability with nvim-cmp
      do
        -- If you want insert `(` after select function or method item
        local autopairs = require("nvim-autopairs.completion.cmp")
        require("cmp").event:on(
          "confirm_done",
          autopairs.on_confirm_done {}
        )
      end
    end,
    event = "InsertEnter",
  }
  -- }}}

  -- Extensions {{{
  -- Move function arguments
  use "AndrewRadev/sideways.vim"
  -- Switch text segments
  use "AndrewRadev/switch.vim"
  -- Create custom submodes and menus
  use {
    "anuvyklack/hydra.nvim",
    config = function()
      require("plugins.hydra")
    end,
  }
  -- Create key bindings that stick
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end,
  }
  -- Surround delimiter pairs with ease
  use {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {
        keymaps = {
          normal = "sa",
          delete = "sd",
          change = "sr",
        },
        delimiters = {
          pairs = {
            [" "] = { " ", " " },
          },
        },
      }
    end,
  }
  use {
    -- Modal multiple cursors
    "mg979/vim-visual-multi",
    config = function()
      vim.g.VM_leader = "\\"
    end,
  }
  -- Searches, substitutions, and abbreviations
  use "tpope/vim-abolish"
  -- Comment stuff out
  use "tpope/vim-commentary"
  -- Unix file manipulation
  use "tpope/vim-eunuch"
  -- Repeat plugin maps
  use "tpope/vim-repeat"
  -- Increment dates, times, and more
  use "tpope/vim-speeddating"
  -- Handy bracket mappings
  use "tpope/vim-unimpaired"
  -- Additional text objects
  use "wellle/targets.vim"
  -- Handle line numbers in file names
  use "wsdjeg/vim-fetch"
  -- }}}

  -- Formatting: {{{
  use {
    -- Format runner
    "mhartington/formatter.nvim",
    config = function()
      require("plugins.formatter")
    end
  }
  -- }}}

  -- Git {{{
  use {
    -- Git integration for buffers
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
    requires = "nvim-lua/plenary.nvim",
  }
  use {
    "TimUntersberger/neogit",
    config = function()
      require("neogit").setup {
        integrations = {
          diffview = true,
        },
      }
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
  }
  -- }}}

  -- LSP {{{
  use {
    -- Ui for nvim-lsp progress
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end,
  }
  use {
    {
      -- Lsp common configurations
      "neovim/nvim-lspconfig",
      config = function()
        require("plugins.lspconfig")
      end,
    },
    -- Add pictograms to LSP
    "onsails/lspkind-nvim",
  }
  -- Portable package manager for Neovim
  use {
    "williamboman/mason.nvim",
    config = function()
      require("plugins.mason")
    end,
    requires = "williamboman/mason-lspconfig.nvim",
  }
  -- }}}

  -- Snippets: {{{
  use {
    -- Snippet engine
    "dcampos/nvim-snippy",
    config = function()
      require("plugins.snippy")
    end,
    requires = "honza/vim-snippets",
  }
  -- }}}

  -- Text {{{
  use {
    -- Show vertical lines for indent
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline")
    end,
  }
  -- Heuristically set buffer options
  use "tpope/vim-sleuth"
  -- Whitespace management
  use {
    "zakharykaplan/nvim-retrail",
    config = function()
      require("retrail").setup {}
    end,
  }
  -- }}}

  -- Treesitter {{{
  use {
    -- Treesitter configurations
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("plugins.nvim-treesitter")
    end,
    run = ":TSUpdate",
  }
  -- Show code context
  use "nvim-treesitter/nvim-treesitter-context"
  -- }}}

  -- User Interface {{{
  use {
    -- Snazzy bufferline
    "akinsho/bufferline.nvim",
    config = function()
      require("plugins.bufferline")
    end,
    requires = "kyazdani42/nvim-web-devicons",
  }
  use {
    -- Ultra fold in Neovim
    "kevinhwang91/nvim-ufo",
    config = function()
      require("ufo").setup {
        open_fold_hl_timeout = 0,
      }
    end,
    requires = "kevinhwang91/promise-async"
  }
  use {
    -- File explorer written in lua
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree")
    end,
    cmd = "NvimTreeToggle",
    keys = {
      { "n", "<Leader>n" },
      { "n", "<Leader>N" },
    },
    requires = "kyazdani42/nvim-web-devicons",
  }
  use {
    -- Blazing fast statusline
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
    requires = {
      "kyazdani42/nvim-web-devicons",
      opt = true
    },
  }
  use {
    -- Fuzzy finder over lists
    "nvim-telescope/telescope.nvim",
    config = function()
      require("plugins.telescope")
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    },
  }
  -- Improve the default vim.ui interfaces
  use "stevearc/dressing.nvim"
  -- }}}

  -- Automatically set up your configuration after cloning packer.nvim
  -- (Put this at the end after all plugins)
  if bootstrap then
    require("packer").sync()
  end
end)

-- vim:fdl=0:fdm=marker:
