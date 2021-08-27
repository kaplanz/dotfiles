-- File:        compe.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     08 Aug 2021
-- SPDX-License-Identifier: MIT

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      -- Icons and a name of kind
      vim_item.kind = lspkind.presets.default[vim_item.kind]
        .. ' '
        .. vim_item.kind
      -- Name of each source
      vim_item.menu = ({
        -- Common
        path   = '[Path]',
        buffer = '[Buffer]',
        calc   = '[Calc]',
        -- Neovim-specific
        nvim_lsp = '[LSP]',
        nvim_lua = '[Lua]',
        -- External plugins
      })[entry.source.name]
      -- Return the formatted item
      return vim_item
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
  preselect = cmp.PreselectMode.None,
  sources = {
    -- Neovim-specific
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    -- External plugins
    -- Common
    { name = 'path' },
    { name = 'buffer' },
    { name = 'calc' },
  },
}
