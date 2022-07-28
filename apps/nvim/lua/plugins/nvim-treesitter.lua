-- File:        nvim-treesitter.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

require("nvim-treesitter.configs").setup {
  -- Consistent syntax highlighting.
  highlight = {
    enable = true,
  },
  -- Incremental selection based on the named nodes from the grammar.
  incremental_selection = {
    enable = true,
    -- Mappings for incremental selection (visual mappings)
    keymaps = {
      -- Init the note/scope selection
      init_selection    = "<M-w>",
      -- Increment to the upper named parent
      node_incremental  = "<M-w>",
      -- Increment to the upper scope (as defined in locals.scm)
      scope_incremental = "<M-C-w>",
      -- Decrement to the previous node
      node_decremental  = "<M-e>",
    },
  },
  -- Indentation based on treesitter for the `=` operator.
  indent = {
    enanle = true,
  },
  -- Syntax aware text-objects, select, move, swap, and peek support.
  textobjects = {
    -- Text object selection
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    },
    -- Swap text objects
    swap = {
      enable = true,
      swap_next = {
        ["<M-l>"] = { "@parameter.inner" },
      },
      swap_previous = {
        ["<M-h>"] = { "@parameter.inner" },
      },
    },
    -- Go to next/previous text object
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = { "@function.outer", "@class.outer" },
      },
      goto_next_end = {
        ["]M"] = { "@function.outer", "@class.outer" },
      },
      goto_previous_start = {
        ["[m"] = { "@function.outer", "@class.outer" },
      },
      goto_previous_end = {
        ["[M"] = { "@function.outer", "@class.outer" },
      },
    },
    -- LSP interop
    lsp_interop = {
      enable = true,
      border = "rounded",
      peek_definition_code = {
        ["<M-k>"]   = "@function.outer",
        ["<M-C-k>"] = "@class.outer",
      },
    },
  },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr   = "nvim_treesitter#foldexpr()"
