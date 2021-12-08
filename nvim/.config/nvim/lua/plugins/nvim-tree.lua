-- File:        nvim-tree.vim
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     08 Aug 2021
-- SPDX-License-Identifier: MIT

-- Set global options
vim.g.nvim_tree_add_trailing           = 1
vim.g.nvim_tree_follow                 = 1
vim.g.nvim_tree_gitignore              = 1
vim.g.nvim_tree_group_empty            = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_icons = { default = '', symlink = '', }
vim.g.nvim_tree_ignore = {'.git', 'node_modules'}
vim.g.nvim_tree_symlink_arrow = ' -> '

-- Require module setup
require('nvim-tree').setup {
  -- disables netrw completely
  disable_netrw       = false,
  -- hijack netrw window on startup
  hijack_netrw        = false,
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close          = true,
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = true,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = true,
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = true,
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
}

-- Configure mappings
do
  local function map(...) vim.api.nvim_set_keymap(...) end
  local opts = { noremap = true, silent = true }

  -- Leader mappings
  map('n', '<Leader>n', '<Cmd>NvimTreeToggle<CR>', opts)
  map('n', '<Leader>N', '<Cmd>NvimTreeRefresh<CR>', opts)
end
