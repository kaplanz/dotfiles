-- File:        init.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     05 Jul 2022
-- SPDX-License-Identifier: MIT

-- Set autocommands
require("vimrc.autocmds")

-- Set colorscheme
vim.cmd [[silent! colorscheme everforest]]

-- Set keymaps
require("vimrc.keymaps")

-- Set options
require("vimrc.options")
