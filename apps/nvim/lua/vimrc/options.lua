-- File:        options.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     05 Jun 2019
-- SPDX-License-Identifier: MIT

----------------
--  Options   --
----------------

-- Buffers {{{
vim.opt.confirm    = true
vim.opt.undofile   = true
vim.opt.updatetime = 100
-- }}}

-- Colours {{{
vim.opt.termguicolors = true
-- }}}

-- Completion {{{
vim.opt.completeopt = { "menuone", "noselect" }
-- }}}

-- Cursor {{{
vim.opt.cursorline = true
vim.opt.whichwrap  = "b,s,<,>,[,]"
-- }}}

-- Indentation {{{
vim.opt.expandtab   = true
vim.opt.shiftround  = true
vim.opt.shiftwidth  = 4
vim.opt.softtabstop = -1
-- }}}

-- Input {{{
vim.opt.mouse = "ar"
-- }}}

-- Path {{{
vim.opt.path:append("**")
-- }}}

-- Search {{{
vim.opt.ignorecase = true
vim.opt.smartcase  = true
-- }}}

-- User Interface {{{
vim.opt.fillchars:append {
  diff      = "╱",
  foldclose = "▶",
  foldopen  = "▼",
}
vim.opt.foldcolumn    = "auto:1"
vim.opt.list          = true
vim.opt.listchars:append {
  trail    = "·",
  tab      = "--|",
  extends  = "›",
  precedes = "‹",
}
vim.opt.number        = true
vim.opt.pumblend      = 10
vim.opt.scrolloff     = 5
vim.opt.showbreak     = "↪ "
vim.opt.showmode      = false
vim.opt.sidescrolloff = 5
vim.opt.winblend      = 10
vim.opt.wrap          = false
-- }}}

-- Window {{{
vim.opt.splitbelow = true
vim.opt.splitright = true
-- }}}

-- vim:fdl=0:fdm=marker:
