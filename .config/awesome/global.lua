local beautiful = require "beautiful"
local awful = require "awful"
local menubar = require "menubar"
local gears = require "gears"

require "awful.autofocus"
require "awful.hotkeys_popup.keys"

local function setup()
  awesome = awesome or {}
  client = client or {}
  root = root or {}
  -- This is used later as the default terminal and editor to run.
  terminal = "kitty"
  editor = os.getenv "EDITOR" or "nvim"
  editor_cmd = terminal .. " -e " .. editor
  beautiful.init "~/.config/awesome/theme.lua"

  gears.timer {
    timeout = 10,
    autostart = true,
    callback = function()
      collectgarbage "collect"
    end,
  }

  awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
  }

  -- Default modkey.
  -- Usually, Mod4 is the key with a logo between Control and Alt.
  -- If you do not like this or do not have such a key,
  -- I suggest you to remap Mod4 to another key using xmodmap or other tools.
  -- However, you can use another modifier like Mod1, but it may interact with others.
  modkey = "Mod4"
  -- Create a launcher widget and a main menu

  -- Menubar configuration
  -- Create a launcher widget and a main menu
  myawesomemenu = {
    { "restart", awesome.restart },
    {
      "quit",
      function()
        awesome.quit()
      end,
    },
  }

  mymainmenu = awful.menu {
    items = {
      { "awesome", myawesomemenu, beautiful.awesome_icon },
      { "open terminal", terminal },
    },
  }

  mylauncher = awful.widget.launcher { image = beautiful.awesome_icon, menu = mymainmenu }
  menubar.utils.terminal = terminal -- Set the terminal for applications that require it

  local function apply_wallpaper(wallpaper, screen)
    -- gears.wallpaper.fit(wallpaper, screen)
    gears.wallpaper.maximized(wallpaper, screen, true)
  end

  local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
      end
      apply_wallpaper(wallpaper, s)
    end
  end

  awesome.connect_signal("wallpaper::change", function(wallpaper)
    wallpaper = wallpaper or beautiful.wallpaper
    for s in screen do
      apply_wallpaper(wallpaper, s)
    end
  end)

  -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
  screen.connect_signal("property::geometry", set_wallpaper)

  awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    require("topbar").setup(s)
  end)

  -- Table of layouts to cover with awful.layout.inc, order matters.
end

return {
  setup = setup,
}
