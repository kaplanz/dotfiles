-- File:        nvim-autopairs.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     10 Oct 2021
-- SPDX-License-Identifier: MIT

require('nvim-autopairs').setup {}

-- If you want insert `(` after select function or method item
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
