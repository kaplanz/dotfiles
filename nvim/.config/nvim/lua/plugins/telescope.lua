-- File:        telescope.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

-- Run vim commands
vim.cmd [[
  " Find files using Telescope command-line sugar.
  nnoremap <Leader>F  <Cmd>Telescope<CR>
  nnoremap <Leader>ff <Cmd>Telescope find_files<CR>
  nnoremap <Leader>fg <Cmd>Telescope live_grep<CR>
  nnoremap <Leader>fb <Cmd>Telescope buffers<CR>
  nnoremap <Leader>fh <Cmd>Telescope help_tags<CR>

  " Remap <C-p> to emulate ctrlp.vim
  nmap <C-p> <Leader>ff
]]

-- Require module setup
require('telescope').setup {}

-- Load extensions
require('telescope').load_extension('notify')
