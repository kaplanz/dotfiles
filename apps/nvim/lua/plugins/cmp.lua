-- File:        cmp.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
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
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
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
      behavior = cmp.SelectBehavior.Select
    }),
    ['<Down>'] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Insert
    }),
    ['<Up>'] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Insert
    }),
    ['<Tab>'] = function(fallback)
      local copilot = vim.fn['copilot#Accept']()
      if cmp.visible() then
        cmp.select_next_item()
      elseif copilot ~= '' then
        vim.api.nvim_feedkeys(copilot, 'i', false)
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
      require('snippy').expand_snippet(args.body)
    end,
  },

  -- Customize completion menu appearance
  formatting = {
    format = function(entry, item)
      -- Icon and name of kind
      item.kind = string.format('%s %s', lspkind.presets.default[item.kind], item.kind)

      -- Item menu
      item.menu = ({
        -- Internal Sources
        spell       = '暈',
        buffer      = ' ' ,
        calc        = ' ' ,
        cmdline     = ' ',
        path        = 'ﱮ ',
        -- External Sources
        cmp_tabnine = 'ﲴ ',
        -- Language Server Protocol
        nvim_lsp    = 'ﮒ ',
        nvim_lua    = ' ',
        -- Extensions
        snippy      = ' ',
        treesitter  = ' ',
        -- Filetype
        crates      = ' ',
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
    -- Extensions
    { name = 'snippy' },
    -- Language Server Protocol
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    -- Filetype
    { name = 'crates' },
    -- Extensions
    { name = 'treesitter' },
    -- External Sources
    { name = 'cmp_tabnine' },
    -- Internal Sources
    { name = 'path' },
    { name = 'buffer' },
    { name = 'cmdline' },
    { name = 'calc' },
    { name = 'spell' },
  },

  -- Enable experimental features
  experimental = {
    ghost_text = true,
  }
}

-- Completions for command mode
cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})

-- Completions for `/` search based on current buffer
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
