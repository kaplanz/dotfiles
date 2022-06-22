-- File:        indent-blankline.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

require('indent_blankline').setup {
  filetype_exclude = {
    'NvimTree',
    'help',
    'packer',
  },
  buftype_exclude = {
    'nofile',
    'terminal',
  },
}
