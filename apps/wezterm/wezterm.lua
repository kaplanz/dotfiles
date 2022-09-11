-- File:        wezterm.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     23 May 2022
-- SPDX-License-Identifier: MIT
-- Vim:         set fdl=0 fdm=marker:

local wezterm = require("wezterm");

return {
  -- Colours: {{{
  color_scheme = "iceberg-dark",
  -- }}}

  -- Font: {{{
  allow_square_glyphs_to_overflow_width = "Never",
  font = wezterm.font_with_fallback {
    "Fira Code",
  },
  harfbuzz_features = {
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
  },
  text_background_opacity = 0.85,
  use_cap_height_to_scale_fallback_fonts = true,
  -- }}}

  -- OS: {{{
  native_macos_fullscreen_mode = true,
  -- }}}

  -- Shell: {{{
  exit_behavior = "Close",
  -- }}}

  -- Tabs: {{{
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  -- }}}

  -- Window: {{{
  initial_cols = 96,
  initial_rows = 32,
  use_resize_increments = true,
  window_background_opacity = 0.95,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  window_padding = {
    left = 6,
    right = 6,
    top = 6,
    bottom = 6,
  },
  -- }}}
}
