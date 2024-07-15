local wez = require("wezterm")
local act = wez.action
local callback = wez.action_callback

local mod = {
  c = "CTRL",
  s = "SHIFT",
  a = "ALT",
  l = "LEADER",
}

local keybind = function(mods, key, action)
  return { mods = table.concat(mods, "|"), key = key, action = action }
end

local M = {}

local leader = { mods = mod.c, key = "a", timeout_miliseconds = 3000 }
-- local leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 3000 }

local keys = function()
  local keys = {
    -- CTRL-A, CTRL-A sends CTRL-A
    keybind({ mod.l, mod.c }, "a", act.SendString("\x01")),

    -- pane and tabs
    keybind({ mod.l }, ".", act.SplitVertical({ domain = "CurrentPaneDomain" })),
    keybind({ mod.l }, "/", act.SplitHorizontal({ domain = "CurrentPaneDomain" })),
    keybind({ mod.l }, "z", act.TogglePaneZoomState),
    keybind({ mod.l }, "t", act.SpawnTab("CurrentPaneDomain")),
    keybind({ mod.l }, "y", act.CloseCurrentTab({ confirm = true })),
    keybind({ mod.l }, "LeftArrow", act.ActivatePaneDirection("Left")),
    keybind({ mod.l }, "DownArrow", act.ActivatePaneDirection("Down")),
    keybind({ mod.l }, "UpArrow", act.ActivatePaneDirection("Up")),
    keybind({ mod.l }, "RightArrow", act.ActivatePaneDirection("Right")),
    keybind({ mod.l }, "x", act.CloseCurrentPane({ confirm = true })),
    keybind({ mod.l, mod.s }, "H", act.AdjustPaneSize({ "Left", 5 })),
    keybind({ mod.l, mod.s }, "J", act.AdjustPaneSize({ "Down", 5 })),
    keybind({ mod.l, mod.s }, "K", act.AdjustPaneSize({ "Up", 5 })),
    keybind({ mod.l, mod.s }, "L", act.AdjustPaneSize({ "Right", 5 })),

    -- workspaces
    keybind({ mod.l }, "w", act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" })),

    -- copy and paste
    keybind({ mod.c, mod.s }, "c", act.CopyTo("Clipboard")),
    keybind({ mod.c, mod.s }, "v", act.PasteFrom("Clipboard")),

    -- launch spotify_player as a small pane in the bottom
    keybind(
      { mod.l },
      "s",
      act.SplitPane({
        direction = "Down",
        command = { args = { "spotify_player" } },
        size = { Cells = 6 },
      })
    ),
    -- -- launch lazygit
    -- keybind(
    --   { mod.l, mod.s },
    --   "G",
    --   act.({
    --     direction = "Right",
    --     command = { args = { "lazygit" } },
    --     size = { Percent = 50 },
    --   })
    -- ),
    -- launch lazygit to the right
    keybind(
        { mod.l },
        "g",
        act.SplitPane({
          direction = "Right",
          command = { args = { "lazygit" } },
          size = { Percent = 50 },
        })
      ),
  

    -- update all plugins
    keybind(
      { mod.l },
      "u",
      callback(function(win)
        wez.plugin.update_all()
        win:toast_notification("wezterm", "plugins updated!", nil, 4000)
      end)
    ),
  }

  -- tab navigation
  for i = 1, 9 do
    table.insert(keys, keybind({ mod.l }, tostring(i), act.ActivateTab(i - 1)))
  end
  return keys
end

M.apply_to_config = function(c)
  c.treat_left_ctrlalt_as_altgr = true
  c.leader = leader
  c.keys = keys()
end

return M