-- File:        wezterm.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     23 May 2022
-- SPDX-License-Identifier: MIT
-- Vim:         set fdl=0 fdm=marker:

local wezterm = require("wezterm")

local config = wezterm.config_builder()


-- Behaviour: {{{
config.exit_behavior = "Close"
config.native_macos_fullscreen_mode = true
-- }}}

-- Colour: {{{
config.color_scheme = "iceberg-dark"
-- }}}

-- Keymaps {{{
config.keys = {
  {
    key = "LeftArrow",
    mods = "SUPER",
    action = wezterm.action.SplitPane {
      direction = "Left",
    }
  },
  {
    key = "RightArrow",
    mods = "SUPER",
    action = wezterm.action.SplitPane {
      direction = "Right",
    }
  },
  {
    key = "UpArrow",
    mods = "SUPER",
    action = wezterm.action.SplitPane {
      direction =  "Up",
    }
  },
  {
    key = "DownArrow",
    mods = "SUPER",
    action = wezterm.action.SplitPane {
      direction =  "Down",
    }
  },
}
-- }}}

-- Text: {{{
config.allow_square_glyphs_to_overflow_width = "Never"
config.font = wezterm.font "Fira Code"
config.font_size = 13.2
config.font_rules = {
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font {
      family = "Victor Mono",
      weight = "Bold",
      style = "Italic",
    },
  },
  {
    italic = true,
    intensity = "Half",
    font = wezterm.font {
      family = "Victor Mono",
      weight = "DemiBold",
      style = "Italic",
    },
  },
  {
    italic = true,
    intensity = "Normal",
    font = wezterm.font {
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
config.use_fancy_tab_bar = false
config.use_resize_increments = true
config.window_background_opacity = 0.95
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
