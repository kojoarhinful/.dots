local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Colors
config.colors = {
  foreground = "#c3cbd9",
  background = "#181817",

  -- cursor (orange, matches the sweet theme)
  cursor_bg = "#ff9a3c",
  cursor_fg = "#1b1f2b",
  cursor_border = "#ff9a3c",

  -- selection
  selection_bg = "#2d2d2d",
  selection_fg = "#c3cbd9",

  -- black, red, green, yellow, blue, magenta, cyan, white
  ansi = {
    "#121212", "#d9737d", "#8fa588", "#ebcb8b",
    "#a89ed6", "#b48ead", "#78b5bf", "#c3cbd9",
  },

  -- brighter versions of the same colors
  brights = {
    "#5c6a82", "#e58f98", "#a3bc9b", "#f2d9a3",
    "#bdb4e6", "#c7a5c0", "#96cbd4", "#eef0f5",
  },
}

-- Font (press ALT+F to cycle through them)
local fonts = {
  'Datatype',
  'Google Sans Code',
  'DM Mono',
}
local font_index = 1

config.font = wezterm.font(fonts[font_index])
config.font_size = 11.3

-- Window
config.initial_cols = 130
config.initial_rows = 38
config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = true
-- config.window_background_opacity = 0.85

-- Input
config.enable_kitty_keyboard = true

-- Keys
config.keys = {
  -- Ctrl+Backspace -> send Ctrl+W (delete previous word), so tmux never sees Ctrl+H
  {
    key = 'Backspace',
    mods = 'CTRL',
    action = wezterm.action.SendKey { key = 'w', mods = 'CTRL' },
  },
  {
    key = 'f',
    mods = 'ALT',
    action = wezterm.action_callback(function(window, pane)
      font_index = font_index % #fonts + 1
      local name = fonts[font_index]
      local overrides = window:get_config_overrides() or {}
      overrides.font = wezterm.font(name)
      window:set_config_overrides(overrides)
      window:toast_notification('WezTerm', name, nil, 2000)
    end),
  },
}

return config
