-- File:        wezterm.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     23 May 2022
-- SPDX-License-Identifier: MIT
-- Vim:         set fdl=0 fdm=marker:

----------------
--  Prelude   --
----------------

-- Imports
local os   = require("os")
local wz   = require("wezterm")

-- Modules
local act  = wz.action
local font = wz.font
local mux  = wz.mux

-- Constants
local xdir = {
  cache = (os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")) .. "/wezterm",
}
local path = {
  WINSZ = xdir.cache .. "/winsz.txt",
}

-- Variables
local cfg  = wz.config_builder()


----------------
--  Settings  --
----------------

-- Behaviour: {{{
cfg.check_for_updates = false
cfg.exit_behavior = "Close"
cfg.native_macos_fullscreen_mode = true
cfg.show_update_window = false
-- }}}

-- Colour: {{{
cfg.color_scheme = "iceberg-dark"
-- }}}

-- Domains: {{{
local domains = {}
-- Set up SSH domains
domains.ssh = {}
for host, _ in pairs(wz.enumerate_ssh_hosts()) do
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
cfg.ssh_domains = domains.ssh
-- }}}

-- Events: {{{
-- Edit this file when the "edit-config" event is emmitted.
wz.on("edit-config", function(window, pane)
  -- Use the user's preference of editor
  local edit = os.getenv("VISUAL") or os.getenv("EDITOR") or "vi"
  local file = wz.config_file

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

-- Keymaps {{{
cfg.keys = {
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
      direction = "Up",
    }
  },
  {
    key = "DownArrow",
    mods = "SUPER",
    action = act.SplitPane {
      direction = "Down",
    }
  },
  {
    key = ",",
    mods = "SUPER",
    action = act.EmitEvent "edit-config",
  },
  {
    key = "w",
    mods = "SUPER",
    action = act.CloseCurrentTab { confirm = false },
  },
}
-- }}}

-- Text: {{{
cfg.allow_square_glyphs_to_overflow_width = "Never"
cfg.font = font "Fira Code"
cfg.font_size = 13.2
cfg.font_rules = {
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
cfg.harfbuzz_features = {
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
cfg.text_background_opacity = 0.85
cfg.use_cap_height_to_scale_fallback_fonts = true
-- }}}

-- Window: {{{
cfg.hide_tab_bar_if_only_one_tab = true
cfg.initial_cols = 96
cfg.initial_rows = 32
cfg.macos_window_background_blur = 20
cfg.use_fancy_tab_bar = false
cfg.use_resize_increments = true
cfg.window_background_opacity = 0.85
cfg.window_close_confirmation = "NeverPrompt"
cfg.window_decorations = "RESIZE"
cfg.window_padding = {
  left = 6,
  right = 6,
  top = 6,
  bottom = 6,
}
-- }}}

return cfg
