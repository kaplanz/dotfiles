-- File:        formatter.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     06 Dec 2021
-- SPDX-License-Identifier: MIT

require("formatter").setup {
  filetype = {
    python = {
      -- Configuration for psf/black
      function()
        return {
          exe = "black", -- this should be available on your $PATH
          args = { "-" },
          stdin = true,
        }
      end
    }
  }
}

vim.keymap.set("n", "<Space>f", "<Cmd>Format<CR>", { noremap = true, silent = true })
