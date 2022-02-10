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
  on_attach = function(bufnr)
    -- if vim.api.nvim_buf_get_name(bufnr):match(<PATTERN>) then
    --   -- Don't attach to specific buffers whose name matches a pattern
    --   return false
    -- end

    -- Setup keymaps
    -- TODO: Update to Nvim 0.7.0
    local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local gs = package.loaded.gitsigns
    local opts = { noremap = true, silent = true }
    local prefix = '<Leader>h'

    -- Navigation
    map('n', ']c', [[&diff ? ']c' : '<Cmd>lua require("gitsigns").next_hunk()<CR>']], { expr = true })
    map('n', '[c', [[&diff ? '[c' : '<Cmd>lua require("gitsigns").prev_hunk()<CR>']], { expr = true })

    -- Actions
    map('n', prefix .. 's',  '<Cmd>lua require("gitsigns").stage_hunk()<CR>', opts)
    map('v', prefix .. 's',  '<Cmd>lua require("gitsigns").stage_hunk()<CR>', opts)
    map('n', prefix .. 'r',  '<Cmd>lua require("gitsigns").reset_hunk()<CR>', opts)
    map('v', prefix .. 'r',  '<Cmd>lua require("gitsigns").reset_hunk()<CR>', opts)
    map('n', prefix .. 'S',  '<Cmd>lua require("gitsigns").stage_buffer()<CR>', opts)
    map('n', prefix .. 'u',  '<Cmd>lua require("gitsigns").undo_stage_hunk()<CR>', opts)
    map('n', prefix .. 'R',  '<Cmd>lua require("gitsigns").reset_buffer()<CR>', opts)
    map('n', prefix .. 'p',  '<Cmd>lua require("gitsigns").preview_hunk()<CR>', opts)
    map('n', prefix .. 'b',  '<Cmd>lua require("gitsigns").blame_line{full=true}<CR><CR>', opts)
    map('n', prefix .. 'tb', '<Cmd>lua require("gitsigns").toggle_current_line_blame()<CR>', opts)
    map('n', prefix .. 'd',  '<Cmd>lua require("gitsigns").diffthis()<CR>', opts)
    map('n', prefix .. 'D',  '<Cmd>lua require("gitsigns").diffthis("~")<CR>', opts)
    map('n', prefix .. 'td', '<Cmd>lua require("gitsigns").toggle_deleted<CR>', opts)

    -- Text object
    map('o', 'ih', ':<C-U>lua require("gitsigns").select_hunk()<CR>', opts)
    map('x', 'ih', ':<C-U>lua require("gitsigns").select_hunk()<CR>', opts)
  end,
}
