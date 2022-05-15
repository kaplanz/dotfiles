-- File:        telescope.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

-- Require module setup
require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    -- Determines the direction "better" results are sorted towards.
    sorting_strategy = 'ascending',
    -- Determines the default layout of Telescope pickers.
    layout_strategy = 'flex',
    -- Determines the default configuration values for layout strategies.
    layout_config = {
      -- Horizontal layout has two columns, one for the preview and one for the
      -- prompt and results.
      horizontal = {
        prompt_position = 'top',
      },
      -- Vertical layout stacks the items on top of each other.
      vertical = {
        mirror = true,
        prompt_position = 'top',
      },
    },
    -- Configure winblend for telescope floating windows.
    winblend = 10,
    -- The character(s) that will be shown in front of Telescope's prompt.
    prompt_prefix = ' ',
    -- The character(s) that will be shown in front of the current selection.
    selection_caret = '» ',
    -- Prefix in front of each result entry. Current selection not included.
    entry_prefix = '  ',
    -- Symbol to add in front of a multi-selected result entry.
    multi_icon = '+',
    -- Boolean defining if borders are added to Telescope windows.
    border = true,
    -- Your mappings to override telescope's default mappings.
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ['<C-h>'] = 'which_key',
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' }
    },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}

-- Configure mappings
do
  -- Set up keymaps
  local opts = { noremap = true, silent = true }

  -- Prefix mappings
  local prefix = '<C-j>'
  vim.keymap.set('n', prefix, '<Cmd>Telescope<CR>', opts)
  vim.keymap.set('n', prefix .. 'a',    '<Cmd>lua require("telescope.builtin").find_files({ hidden = true })<CR>', opts)
  vim.keymap.set('n', prefix .. 'b',    '<Cmd>lua require("telescope.builtin").buffers()<CR>', opts)
  vim.keymap.set('n', prefix .. 'f',    '<Cmd>lua require("telescope.builtin").find_files()<CR>', opts)
  vim.keymap.set('n', prefix .. 'g',    '<Cmd>lua require("telescope.builtin").live_grep()<CR>', opts)
  vim.keymap.set('n', prefix .. 'h',    '<Cmd>lua require("telescope.builtin").help_tags()<CR>', opts)
  vim.keymap.set('n', prefix .. 'o',    '<Cmd>lua require("telescope.builtin").oldfiles()<CR>', opts)
  vim.keymap.set('n', prefix .. 's',    '<Cmd>lua require("telescope.builtin").git_status()<CR>', opts)
  vim.keymap.set('n', prefix .. prefix, '<Cmd>lua require("telescope.builtin").resume()<CR>', opts)

  -- Shortcuts
  vim.keymap.set('n', '<C-p>', prefix .. 'f', { remap = true, silent = true })   -- find_files
  vim.keymap.set('n', 'gb', prefix .. 'b', { remap = true, silent = true })      -- buffers
end

-- To get extensions loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
