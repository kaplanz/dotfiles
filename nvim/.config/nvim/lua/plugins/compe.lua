-- File:        compe.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     08 Aug 2021
-- SPDX-License-Identifier: MIT

require('compe').setup {
  enabled = true,
  autocomplete = true,
  source = {
    -- Common
    path = true,
    buffer = true,
    tags = true,
    spell = false,
    calc = true,
    omni = false,
    emoji = true,
    -- Neovim-specific
    nvim_lsp = true,
    nvim_lua = true,
    -- External plugins
  },
}

vim.cmd [[
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-y>     compe#confirm('<C-y>')
inoremap <silent><expr> <CR>      compe#confirm(parry#cr())
]]
