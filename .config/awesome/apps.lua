local awful = require "awful"

local function bg_apps()
  local background_apps = {
    [[xinput set-prop "$(xinput list --name-only | grep -i touch)" "libinput Natural Scrolling Enabled" 1]],
    [[xinput set-prop "$(xinput list --name-only | grep -i touch)" "libinput Tapping Enabled" 1]],
  }

  for _, app in ipairs(background_apps) do
    awful.spawn.with_shell(app)
  end
end

-- start only one time
local function bg_apps_once()
  local background_apps_once = {
    "nm-applet",
    "blueman-applet",
    "setupKeyboard",
    "flameshot",
  }

  for _, app in ipairs(background_apps_once) do
    awful.spawn.once(app)
  end
end

local function bg_apps_conditional()
  -- If the 2nd command produces no output the it is assumed that no instance
  -- of 1st command is running.
  local unique_apps_with_rules = {
    { "udiskie --no-automount --tray", "pgrep udiskie" },
  }

  for _, app in ipairs(unique_apps_with_rules) do
    awful.spawn.easy_async(app[2], function(stdout)
      if stdout == "" then
        awful.spawn.with_shell(app[1])
      end
    end)
  end
end

local function setup()
  bg_apps()
  bg_apps_once()
  bg_apps_conditional()
end

return {
  setup = setup,
}
