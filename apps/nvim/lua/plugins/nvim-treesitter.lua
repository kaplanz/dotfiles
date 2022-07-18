-- File:        nvim-treesitter.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
}

vim.cmd [[set fdm=expr fde=nvim_treesitter#foldexpr()]]
