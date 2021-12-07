-- File:        cmp.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     08 Aug 2021
-- SPDX-License-Identifier: MIT

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup {
  -- Don't pre-select any item
  preselect = cmp.PreselectMode.None,

  -- Mappings for completions
  mapping = {
    -- Scroll docs
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- Popup behaviour
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Select behaviour
    ['<C-n>'] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Select
    }),
    ['<C-p>'] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Insert
    }),
    ['<Down>'] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Insert
    }),
    ['<Up>'] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Select
    }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    -- Confirm behaviour
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },

  -- Snippet expansion function
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  -- Customize completion menu appearance
  formatting = {
    format = function(entry, item)
      -- Icon and name of kind
      item.kind = string.format('%s %s', lspkind.presets.default[item.kind], item.kind)

      -- Item menu
      item.menu = ({
        -- Common
        buffer      = '﬘',
        calc        = '',
        path        = 'ﱮ',
        spell       = '暈',
        -- Neovim-specific
        nvim_lsp    = '',
        nvim_lua    = '',
        treesitter  = '',
        -- External plugins
        cmp_tabnine = 'ﮧ',
      })[entry.source.name]

      -- Special menu details
      if entry.source.name == 'cmp_tabnine' then
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
          item.menu = string.format('%s %s', item.menu, entry.completion_item.data.detail)
        end
      end

      return item
    end,
  },

  -- Array of the source configuration to use
  -- (The order will be used to the completion menu's sort order)
  sources = {
    -- Neovim-specific
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'treesitter' },
    -- External plugins
    { name = 'cmp_tabnine' },
    -- Common
    { name = 'path' },
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'spell' },
  },

  -- Enable experimental features
  experimental = {
    ghost_text = true,
  }
}
