-- File:        options.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     05 Jun 2019
-- SPDX-License-Identifier: MIT

----------------
--  Options   --
----------------

-- Buffers {{{
vim.o.confirm = true
vim.o.undofile = true
vim.o.updatetime = 100
-- }}}

-- Colours {{{
vim.cmd [[silent! colorscheme nordfox]]
vim.o.termguicolors = true
-- }}}

-- Completion {{{
vim.o.completeopt = "menuone,noselect"
-- }}}

-- Cursor {{{
vim.o.cursorline = true
vim.o.whichwrap = "b,s,<,>,[,]"
-- }}}

-- Indentation {{{
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.softtabstop = -1
-- }}}

-- Input {{{
vim.o.mouse = "ar"
-- }}}

-- Path {{{
vim.o.path = vim.o.path .. ",**"
-- }}}

-- Search {{{
vim.o.ignorecase = true
vim.o.smartcase = true
-- }}}

-- User Interface {{{
vim.o.fillchars = "foldopen:▼,foldclose:▶,diff:╱"
vim.o.foldcolumn = "auto:1"
vim.o.number = true
vim.o.pumblend = 10
vim.o.scrolloff = 5
vim.o.showmode = false
vim.o.sidescrolloff = 5
vim.o.winblend = 10
vim.o.wrap = false
-- }}}

-- Window {{{
vim.o.splitbelow = true
vim.o.splitright = true
-- }}}


-- vim:fdl=0:fdm=marker:
