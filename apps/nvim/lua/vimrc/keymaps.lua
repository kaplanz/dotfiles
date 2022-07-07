-- File:        keymaps.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     12 Sep 2020
-- SPDX-License-Identifier: MIT

-- Set up keymaps
local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

---------------
-- Mapleader --
---------------

-- Change mapleader
vim.g.mapleader = ','
-- Bypass mapleader action
map('n', '<Leader><Leader>', '<Leader>')


---------------
--  Actions  --
---------------

-- Write to file
map('n', '<C-s>', '<Cmd>update<CR>')
-- Open file in vertical split
map('n', '<C-w><C-f>', '<C-w>vgf')
-- Sort Visual mode selection
map('v', '<Leader>o', '<Cmd>sort<CR>')
vim.cmd[[vnoremap <Leader>o :sort<CR>]]
-- Open a new terminal window
map('n', '<Leader>t', '<Cmd>split +terminal<CR>')

-- vim:fdl=0:fdm=marker:
