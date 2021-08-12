-- File:        init.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

-- source vimrc
vim.cmd [[runtime! viml/vimrc]]

-- load plugins
require('plugins')

-- load custom
pcall(require, 'local')

-- vim:fdl=0:fdm=marker:
