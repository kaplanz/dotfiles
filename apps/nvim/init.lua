-- File:        init.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

-- load vimrc
require("vimrc")

-- load plugins
require("plugins")

-- load custom
pcall(require, "local")

-- vim:fdl=0:fdm=marker:
