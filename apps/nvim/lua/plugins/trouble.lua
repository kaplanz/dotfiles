-- File:        trouble.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     21 Jun 2022
-- SPDX-License-Identifier: MIT

require('trouble').setup {}

local ts = package.loaded.trouble

-- -- Set up keymaps
-- local function map(mode, lhs, rhs, opts)
--   opts = opts or { noremap = true, silent = true }
--   vim.keymap.set(mode, lhs, rhs, opts)
-- end

-- -- Actions
-- local prefix = '<Leader>x'
-- map('n', prefix, ts.builtin)
-- map('n', prefix .. 'x', '<Cmd>Trouble<CR>')
-- map('n', prefix .. 'w', '<Cmd>Trouble workspace_diagnostics<CR>')
-- map('n', prefix .. 'd', '<Cmd>Trouble document_diagnostics<CR>')
-- map('n', prefix .. 'l', '<Cmd>Trouble loclist<CR>')
-- map('n', prefix .. 'q', '<Cmd>Trouble quickfix<CR>')
-- map('n', 'gR', '<Cmd>Trouble lsp_references<CR>')
