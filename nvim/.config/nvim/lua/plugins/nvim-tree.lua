-- File:        nvim-tree.vim
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     08 Aug 2021
-- SPDX-License-Identifier: MIT

-- Set global options
vim.g.nvim_tree_add_trailing           = 1
vim.g.nvim_tree_group_empty            = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_icons = { default = '', symlink = '', }
vim.g.nvim_tree_symlink_arrow = ' -> '

-- Require module setup
require('nvim-tree').setup {
  -- completely disable netrw
  disable_netrw       = false,
  -- hijack netrw windows
  hijack_netrw        = false,
  -- keeps the cursor on the first letter of the filename when moving in the tree
  hijack_cursor       = true,
  -- changes the tree root directory on `DirChanged` and refreshes the tree
  update_cwd          = true,
  -- update the focused file on `BufEnter`, un-collapses the folders recursively
  -- until it finds the file
  update_focused_file = {
    -- enable this feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing
    -- the file if the file is not under the current root directory. Only
    -- relevant when `update_focused_file.enable` is `true`
    update_cwd  = false,
    -- list of buffer names and filetypes that will not update the root dir of
    -- the tree if the file isn't found under the current root directory. Only
    -- relevant when `update_focused_file.update_cwd` is `true` and
    -- `update_focused_file.enable` is `true`
    ignore_list = {}
  },
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = true,
  },
  -- git integration with icons and colors
  git = {
    -- ignore files based on `.gitignore`
    ignore = true,
  },
  -- filtering options
  filters = {
    -- custom list of string that will not be shown
    custom = {'.git', 'node_modules'},
  },
}

-- Configure mappings
do
  -- Set up keymaps
  local opts = { noremap = true, silent = true }

  -- Leader mappings
  vim.keymap.set('n', '<Leader>n', '<Cmd>NvimTreeToggle<CR>', opts)
  vim.keymap.set('n', '<Leader>N', '<Cmd>NvimTreeRefresh<CR>', opts)
end
