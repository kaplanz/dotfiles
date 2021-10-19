-- File:        indent-blankline.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

require('indent_blankline').setup {
  filetype_exclude = {
    'NvimTree',
    'help',
    'packer',
    'tagbar',
  },
  buftype_exclude = {
    'nofile',
    'terminal',
  },
}
