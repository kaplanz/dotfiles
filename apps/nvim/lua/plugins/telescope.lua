-- File:        telescope.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

-- Require module setup
require("telescope").setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    -- Determines the direction "better" results are sorted towards.
    sorting_strategy = "ascending",
    -- Determines the default layout of Telescope pickers.
    layout_strategy = "flex",
    -- Determines the default configuration values for layout strategies.
    layout_config = {
      -- Horizontal layout has two columns, one for the preview and one for the
      -- prompt and results.
      horizontal = {
        prompt_position = "top",
      },
      -- Vertical layout stacks the items on top of each other.
      vertical = {
        mirror = true,
        prompt_position = "top",
      },
    },
    -- Configure winblend for telescope floating windows.
    winblend = 10,
    -- The character(s) that will be shown in front of Telescope's prompt.
    prompt_prefix = " ",
    -- The character(s) that will be shown in front of the current selection.
    selection_caret = "» ",
    -- Prefix in front of each result entry. Current selection not included.
    entry_prefix = "  ",
    -- Symbol to add in front of a multi-selected result entry.
    multi_icon = "+",
    -- Boolean defining if borders are added to Telescope windows.
    border = true,
    -- Your mappings to override telescope's default mappings.
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ["<C-h>"] = "which_key",
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
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
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
  local ts = require("telescope.builtin")

  -- Set up keymaps
  local prefix = "<M-s>"
  local function map(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Actions
  map("n", "<C-p>", ts.find_files)
  map("n", "<F1>", ts.help_tags)
  map("n", "<M-S>", ts.builtin)
  map("n", "gb", ts.buffers)
  map("n", prefix .. "a", function() ts.find_files({ hidden = true }) end)
  map("n", prefix .. "g", ts.live_grep)
  map("n", prefix .. "o", ts.oldfiles)
  map("n", prefix .. "r", ts.resume)
  map("n", prefix .. "s", ts.git_status)
  map("n", prefix, ts.builtin)
end

-- To get extensions loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")
