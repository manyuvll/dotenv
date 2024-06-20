local wez = require("wezterm")

local M = {}

M.apply_to_config = function(c)
  c.color_scheme = "rose-pine"
  local scheme = wez.color.get_builtin_schemes()["rose-pine"]
  c.colors = {
    split = scheme.ansi[2],
  }
  c.window_background_opacity = 0.96
  c.macos_window_background_blur = 15
  c.inactive_pane_hsb = { brightness = 0.9 }
  c.window_padding = { left = "1cell", right = "1cell", top = 8, bottom = 0 }
  c.window_decorations = "RESIZE"
  c.show_new_tab_button_in_tab_bar = false
  c.initial_rows = 50
  c.initial_cols = 160
end

return M