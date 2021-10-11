-- File:        bufferline.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     11 Aug 2021
-- SPDX-License-Identifier: MIT

require('bufferline').setup {
  options = {
    view = 'multiwindow',
    numbers = function(opts) return string.format('%s', opts.id) end,
    diagnostics = 'nvim_lsp',
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'NvimTree',
        highlight = 'Directory',
      },
      {
        filetype = 'tagbar',
        text = 'Tagbar',
        highlight = 'Directory',
      },
    },
  },
}
