-- File:        cmp.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     08 Aug 2021
-- SPDX-License-Identifier: MIT

local cmp = require("cmp")
local lspkind = require("lspkind")

-- Nil check for LSP
if not cmp then return end

cmp.setup {
  -- Don't pre-select any item
  preselect = cmp.PreselectMode.None,

  -- Mappings for completions
  mapping = {
    -- Scroll docs
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- Popup behaviour
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Select behaviour
    ["<C-n>"] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Select
    }),
    ["<C-p>"] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Select
    }),
    ["<Down>"] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Insert
    }),
    ["<Up>"] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Insert
    }),
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    -- Confirm behaviour
    ["<C-y>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },

  -- Snippet expansion function
  snippet = {
    expand = function(args)
      require("snippy").expand_snippet(args.body)
    end,
  },

  -- Customize completion menu appearance
  formatting = {
    -- An array of completion fields to specify their order.
    fields = {"kind", "abbr", "menu"},
    -- The function used to customize the appearance of the completion menu.
    format = function(entry, item)
      local symbol = lspkind.symbol_map[item.kind]
      local kind   = item.kind
      local source = ({
        -- Vim-builtin
        spell       = "暈",
        buffer      = " ",
        calc        = " ",
        omni        = " ",
        -- Neovim-builtin
        nvim_lua    = " ",
        treesitter  = "פּ ",
        -- Snippets
        snippy      = " ",
        -- Language Server Protocol
        nvim_lsp    = "ﮒ ",
        nvim_lsp_document_symbol = "ﮒ ",
        -- Filesystem
        path        = "ﱮ ",
        rg          = " ",
        -- Extensions
        cmdline     = " ",
      })[entry.source.name] or " "

      item.kind = symbol
      item.menu = string.format(" %s (%s)", source, kind)

      return item
    end,
  },

  -- Array of the source configuration to use
  -- (The order will be used to the completion menu's sort order)
  sources = cmp.config.sources(
    -- Snippets
    {
      { name = "snippy" },
    },
    -- Language Server Protocol
    {
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
    },
    -- Neovim-builtin
    {
      { name = "nvim_lua" },
      { name = "treesitter" },
    },
    -- Vim-builtin
    {
      { name = "spell" },
      { name = "buffer" },
      { name = "calc" },
      { name = "omni" },
    },
    -- Filesystem
    {
      { name = "path" },
      { name = "rg" },
    },
    -- Extra
    {}
  ),

  -- The view class used to customize nvim-cmp's appearance
  view = {
    entries = {
      name = "custom",
      selection_order = "near_cursor",
    }
  },

  -- Window appearance customization
  window = {},

  -- Enable experimental features
  experimental = {
    ghost_text = true,
  }
}

-- Completions for `/` search based on current buffer
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = "nvim_lsp_document_symbol" },
    { name = "buffer" },
  }
})

-- Completions for command mode
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = "cmdline" },
  }
})
