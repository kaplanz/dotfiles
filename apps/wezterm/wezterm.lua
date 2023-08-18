-- File:        wezterm.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     23 May 2022
-- SPDX-License-Identifier: MIT
-- Vim:         set fdl=0 fdm=marker:

local os = require("os")
local wezterm = require("wezterm")

local act  = wezterm.action
local font = wezterm.font

local config = wezterm.config_builder()

-- Behaviour: {{{
config.check_for_updates = false
config.exit_behavior = "Close"
config.native_macos_fullscreen_mode = true
config.show_update_window = false
-- }}}

-- Colour: {{{
config.color_scheme = "iceberg-dark"
-- }}}

-- Events: {{{
wezterm.on("edit-wezterm-config", function(window, pane)
  -- Use the user's preference of editor
  local edit = os.getenv("VISUAL") or os.getenv("EDITOR") or "vi"
  local file = wezterm.config_file

  -- Open a new tab editing the file
  window:perform_action(act.SpawnCommandInNewWindow {
    args = { edit, file },
    set_environment_variables = {
      EDITOR = os.getenv("EDITOR"),
      PATH   = os.getenv("PATH"),
      VISUAL = os.getenv("VISUAL"),
    },
  }, pane)
end)
-- }}}

-- Domains: {{{
local domains = {}
-- Set up SSH domains
domains.ssh = {}
for host, _ in pairs(wezterm.enumerate_ssh_hosts()) do
  table.insert(domains.ssh, {
    -- The name can be anything you want; we're just using the hostname
    name = host,
    -- Remote_address must be set to `host` for the ssh config to apply to it
    remote_address = host,

    -- If you don't have wezterm's mux server installed on the remote
    -- host, you may wish to set multiplexing = "None" to use a direct
    -- ssh connection that supports multiple panes/tabs which will close
    -- when the connection is dropped.
    multiplexing = "None",

    -- if you know that the remote host has a posix/unix environment,
    -- setting assume_shell = "Posix" will result in new panes respecting
    -- the remote current directory when multiplexing = "None".
    assume_shell = 'Posix',
  })
end
config.ssh_domains = domains.ssh
-- }}}

-- Keymaps {{{
config.keys = {
  {
    key = "LeftArrow",
    mods = "SUPER",
    action = act.SplitPane {
      direction = "Left",
    }
  },
  {
    key = "RightArrow",
    mods = "SUPER",
    action = act.SplitPane {
      direction = "Right",
    }
  },
  {
    key = "UpArrow",
    mods = "SUPER",
    action = act.SplitPane {
      direction =  "Up",
    }
  },
  {
    key = "DownArrow",
    mods = "SUPER",
    action = act.SplitPane {
      direction =  "Down",
    }
  },
  {
    key = ",",
    mods = "SUPER",
    action = act.EmitEvent "edit-wezterm-config",
  },
  {
    key = "w",
    mods = "SUPER",
    action = act.CloseCurrentTab { confirm = false },
  },
}
-- }}}

-- Text: {{{
config.allow_square_glyphs_to_overflow_width = "Never"
config.font = font "Fira Code"
config.font_size = 13.2
config.font_rules = {
  {
    intensity = "Bold",
    italic = true,
    font = font {
      family = "Victor Mono",
      weight = "Bold",
      style = "Italic",
    },
  },
  {
    italic = true,
    intensity = "Half",
    font = font {
      family = "Victor Mono",
      weight = "DemiBold",
      style = "Italic",
    },
  },
  {
    italic = true,
    intensity = "Normal",
    font = font {
      family = "Victor Mono",
      style = "Italic",
    },
  },
}
config.harfbuzz_features = {
  -- character variants
  "cv01", -- a
  "cv02", -- g
  "cv14", -- 3
  "cv18", -- %
  "cv25", -- .-
  "cv26", -- :-
  "cv32", -- .=
  "zero", -- 0
  -- stylistic sets
  "ss01", -- r
  "ss02", -- <= >=
  "ss04", -- $
  "ss06", -- \\
  "ss10", -- Fl Tl fi fj fl ft
}
config.text_background_opacity = 0.85
config.use_cap_height_to_scale_fallback_fonts = true
-- }}}

-- Window: {{{
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 96
config.initial_rows = 32
config.macos_window_background_blur = 20
config.use_fancy_tab_bar = false
config.use_resize_increments = true
config.window_background_opacity = 0.85
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 6,
  right = 6,
  top = 6,
  bottom = 6,
}
-- }}}

return config
