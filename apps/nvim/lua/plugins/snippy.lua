-- File:        snippy.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     27 Mar 2022
-- SPDX-License-Identifier: MIT

require("snippy").setup {
  mappings = {
    is = {
        ["<Tab>"] = "expand_or_advance",
        ["<S-Tab>"] = "previous",
    },
    nx = {
        ["<leader>x"] = "cut_text",
    },
  },
}
