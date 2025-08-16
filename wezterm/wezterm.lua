-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

config.font=wezterm.font 'JetBrainsMono Nerd Font'
config.automatically_reload_config = true
config.color_scheme = 'Catppuccin Mocha (Gogh)'
config.enable_tab_bar=false
config.window_close_confirmation="NeverPrompt"
config.window_decorations="RESIZE"
config.font_size=16
config.hide_tab_bar_if_only_one_tab=true
config.native_macos_fullscreen_mode=false
config.default_cursor_style="BlinkingBar"
config.window_background_opacity = 0.7
config.macos_window_background_blur = 40


-- Finally, return the configuration to wezterm:
return config