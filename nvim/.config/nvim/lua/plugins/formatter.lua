-- File:        formatter.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     06 Dec 2021
-- SPDX-License-Identifier: MIT

require('formatter').setup {
  filetype = {
    python = {
      -- Configuration for psf/black
      function()
        return {
          exe = 'black', -- this should be available on your $PATH
          args = { '-' },
          stdin = true,
        }
      end
    }
  }
}
