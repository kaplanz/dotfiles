-- File:        gitsigns.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
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
  on_attach = function(_)
    -- if vim.api.nvim_buf_get_name(bufnr):match(<PATTERN>) then
    --   -- Don't attach to specific buffers whose name matches a pattern
    --   return false
    -- end

    -- Set up keymaps
    local opts = { noremap = true, silent = true }
    local prefix = '<Leader>h'

    -- Navigation
    vim.keymap.set('n', ']c', [[&diff ? ']c' : '<Cmd>lua require("gitsigns").next_hunk()<CR>']], { expr = true })
    vim.keymap.set('n', '[c', [[&diff ? '[c' : '<Cmd>lua require("gitsigns").prev_hunk()<CR>']], { expr = true })

    -- Actions
    vim.keymap.set('n', prefix .. 's',  '<Cmd>lua require("gitsigns").stage_hunk()<CR>', opts)
    vim.keymap.set('v', prefix .. 's',  '<Cmd>lua require("gitsigns").stage_hunk()<CR>', opts)
    vim.keymap.set('n', prefix .. 'r',  '<Cmd>lua require("gitsigns").reset_hunk()<CR>', opts)
    vim.keymap.set('v', prefix .. 'r',  '<Cmd>lua require("gitsigns").reset_hunk()<CR>', opts)
    vim.keymap.set('n', prefix .. 'S',  '<Cmd>lua require("gitsigns").stage_buffer()<CR>', opts)
    vim.keymap.set('n', prefix .. 'u',  '<Cmd>lua require("gitsigns").undo_stage_hunk()<CR>', opts)
    vim.keymap.set('n', prefix .. 'R',  '<Cmd>lua require("gitsigns").reset_buffer()<CR>', opts)
    vim.keymap.set('n', prefix .. 'p',  '<Cmd>lua require("gitsigns").preview_hunk()<CR>', opts)
    vim.keymap.set('n', prefix .. 'b',  '<Cmd>lua require("gitsigns").blame_line{full=true}<CR><CR>', opts)
    vim.keymap.set('n', prefix .. 'tb', '<Cmd>lua require("gitsigns").toggle_current_line_blame()<CR>', opts)
    vim.keymap.set('n', prefix .. 'd',  '<Cmd>lua require("gitsigns").diffthis()<CR>', opts)
    vim.keymap.set('n', prefix .. 'D',  '<Cmd>lua require("gitsigns").diffthis("~")<CR>', opts)
    vim.keymap.set('n', prefix .. 'td', '<Cmd>lua require("gitsigns").toggle_deleted<CR>', opts)

    -- Text object
    vim.keymap.set('o', 'ih', ':<C-U>lua require("gitsigns").select_hunk()<CR>', opts)
    vim.keymap.set('x', 'ih', ':<C-U>lua require("gitsigns").select_hunk()<CR>', opts)
  end,
}
