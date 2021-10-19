-- File:        gitsigns.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     19 Oct 2021
-- SPDX-License-Identifier: MIT

require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}
