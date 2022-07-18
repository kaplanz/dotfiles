-- File:        gitsigns.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     19 Oct 2021
-- SPDX-License-Identifier: MIT

require("gitsigns").setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Set up keymaps
    local prefix = "<Leader>"
    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr=true })
    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map({"n", "v"}, prefix .. "hs", gs.stage_hunk)
    map({"n", "v"}, prefix .. "hr", gs.reset_hunk)
    map("n", prefix .. "hS", gs.stage_buffer)
    map("n", prefix .. "hu", gs.undo_stage_hunk)
    map("n", prefix .. "hR", gs.reset_buffer)
    map("n", prefix .. "hp", gs.preview_hunk)
    map("n", prefix .. "hb", function() gs.blame_line { full = true } end)
    map("n", prefix .. "tb", gs.toggle_current_line_blame)
    map("n", prefix .. "hd", gs.diffthis)
    map("n", prefix .. "hD", function() gs.diffthis("~") end)
    map("n", prefix .. "td", gs.toggle_deleted)

    -- Text object
    map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
}
