-- File:        mason.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     25 Jul 2022
-- SPDX-License-Identifier: MIT

require("mason").setup {
  ui = {
    -- The border to use for the UI window. Accepts same border values as
    -- |nvim_open_win()|.
    border = "rounded",

    icons = {
      -- The list icon to use for installed packages.
      package_installed = "✓",
      -- The list icon to use for packages that are installing, or queued for
      -- installation.
      package_pending = "➜",
      -- The list icon to use for packages that are not installed.
      package_uninstalled = "✗"
    }
  },
}

require("mason-lspconfig").setup {
  -- A list of servers to automatically install if they're not already
  -- installed.
  -- Example: { "rust_analyzer@nightly", "sumneko_lua" }
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = { "sumneko_lua" },

  -- Whether servers that are set up (via lspconfig) should be automatically
  -- installed if they're not already installed. This setting has no relation
  -- with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the
  --       ones provided in the list, are automatically installed.
  --       Example: automatic_installation = {
    --       exclude = { "rust_analyzer", "solargraph" },
  --       }.
  automatic_installation = true,
}
