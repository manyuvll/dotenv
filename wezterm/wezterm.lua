local wez = require("wezterm")

local appearance = require("lua.appearance")
local bar = require("lua.bottom_bar")
local mappings = require("lua.mappings")

local c = {}

if wez.config_builder then
  c = wez.config_builder()
end

-- General configurations
c.font = wez.font("Fira Code Medium")
c.font_rules = {
  {
    italic = true,
    intensity = "Half",
    font = wez.font("Cartograph CF", { weight = "Regular", italic = true }),
  },
}
c.font_size = 12
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.scrollback_lines = 3000
c.default_workspace = "main"
c.status_update_interval = 2000
c.set_environment_variables = {
  PATH = '/opt/homebrew/bin/:' .. os.getenv('PATH')
}
c.default_prog = { '/opt/homebrew/bin/fish', '-l' }

-- appearance
appearance.apply_to_config(c)

-- keys
mappings.apply_to_config(c)

-- bar
bar.apply_to_config(c, { enabled_modules = { hostname = false } })

return c

