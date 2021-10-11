-- File:        lualine.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

require('lualine').setup {
  options = {
    component_separators = '|',
    disabled_filetypes = {
      'NvimTree',
      'packer',
      'tagbar',
    },
    section_separators = '',
  },
}
