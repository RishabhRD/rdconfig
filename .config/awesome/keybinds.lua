local menubar = require "menubar"
local gears = require "gears"
local hotkeys_popup = require "awful.hotkeys_popup"
local awful = require "awful"
local volume_widget = require "awesome-wm-widgets.volume-widget.volume"

local function setup()
  local globalkeys = gears.table.join(
    awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
    awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
    awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
    awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

    awful.key({ modkey }, "j", function()
      awful.client.focus.byidx(1)
    end, {
      description = "focus next by index",
      group = "client",
    }),
    awful.key({ modkey }, "k", function()
      awful.client.focus.byidx(-1)
    end, {
      description = "focus previous by index",
      group = "client",
    }),
    awful.key({ modkey }, "w", function()
      mymainmenu:show()
    end, { description = "show main menu", group = "awesome" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function()
      awful.client.swap.byidx(1)
    end, {
      description = "swap with next client by index",
      group = "client",
    }),
    awful.key({ modkey, "Shift" }, "k", function()
      awful.client.swap.byidx(-1)
    end, {
      description = "swap with previous client by index",
      group = "client",
    }),
    awful.key({ modkey, "Control" }, "j", function()
      awful.screen.focus_relative(1)
    end, {
      description = "focus the next screen",
      group = "screen",
    }),
    awful.key({ modkey, "Control" }, "k", function()
      awful.screen.focus_relative(-1)
    end, {
      description = "focus the previous screen",
      group = "screen",
    }),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey }, "Tab", function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end, {
      description = "go back",
      group = "client",
    }),

    -- Standard program
    awful.key({ modkey }, "Return", function()
      awful.spawn(terminal)
    end, {
      description = "open a terminal",
      group = "launcher",
    }),
    awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

    awful.key({ modkey }, "l", function()
      awful.tag.incmwfact(0.05)
    end, {
      description = "increase master width factor",
      group = "layout",
    }),
    awful.key({ modkey }, "h", function()
      awful.tag.incmwfact(-0.05)
    end, {
      description = "decrease master width factor",
      group = "layout",
    }),
    awful.key({ modkey, "Shift" }, "h", function()
      awful.tag.incnmaster(1, nil, true)
    end, {
      description = "increase the number of master clients",
      group = "layout",
    }),
    awful.key({ modkey, "Shift" }, "l", function()
      awful.tag.incnmaster(-1, nil, true)
    end, {
      description = "decrease the number of master clients",
      group = "layout",
    }),
    awful.key({ modkey, "Control" }, "h", function()
      awful.tag.incncol(1, nil, true)
    end, {
      description = "increase the number of columns",
      group = "layout",
    }),
    awful.key({ modkey, "Control" }, "l", function()
      awful.tag.incncol(-1, nil, true)
    end, {
      description = "decrease the number of columns",
      group = "layout",
    }),
    awful.key({ modkey, "Shift" }, "t", function()
      awful.layout.inc(1)
    end, {
      description = "select next layout",
      group = "layout",
    }),

    awful.key({ modkey, "Control" }, "i", function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
      end
    end, {
      description = "restore minimized",
      group = "client",
    }),

    -- Prompt
    awful.key({ modkey }, "d", function()
      awful.util.spawn "rofi -show run"
    end, {
      description = "launch rofi",
      group = "launcher",
    }),

    awful.key({ modkey }, "a", function()
      awful.util.spawn "rofi -show drun -theme ~/.config/rofi/themes/launchpad.rasi"
    end, {
      description = "launch applications menu",
      group = "launcher",
    }),

    awful.key({ modkey }, "x", function()
      awful.prompt.run {
        prompt = "Run Lua code: ",
        textbox = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval",
      }
    end, {
      description = "lua execute prompt",
      group = "awesome",
    }),
    -- Menubar
    -- awful.key({ modkey }, "p", function()
    --   menubar.show()
    -- end, { description = "show the menubar", group = "launcher" }),
    awful.key({ modkey }, "equal", function()
      local s = awful.screen.focused()
      for _ = 1, #s.tags do
        awful.tag.viewidx(1, s)
        if #s.clients > 0 then
          return
        end
      end
    end, {
      description = "view next non-empty tag",
      group = "tag",
    }),
    awful.key({ modkey }, "o", function()
      local s = awful.screen.focused()
      for _ = 1, #s.tags do
        awful.tag.viewidx(1, s)
        if #s.clients == 0 then
          return
        end
      end
    end, {
      description = "view next empty tag",
      group = "tag",
    }),

    -- jump to last tag
    awful.key({ modkey }, "e", function()
      local screen = awful.screen.focused()
      local t = previous_tags[screen]
      if t ~= nil then
        t:view_only()
      end
    end)
  )

  -- Bind all key numbers to tags.
  -- Be careful: we use keycodes to make it work on any keyboard layout.
  -- This should map on the top row of your keyboard, usually 1 to 9.
  for i = 1, 9 do
    globalkeys = gears.table.join(
      globalkeys,
      -- View tag only.
      awful.key({ modkey }, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end, {
        description = "view tag #" .. i,
        group = "tag",
      }),
      -- Toggle tag display.
      awful.key({ modkey, "Control" }, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end, {
        description = "toggle tag #" .. i,
        group = "tag",
      }),
      -- Move client to tag.
      awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end, {
        description = "move focused client to tag #" .. i,
        group = "tag",
      }),
      -- Toggle tag on focused client.
      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end, {
        description = "toggle focused client on tag #" .. i,
        group = "tag",
      })
    )
  end

  local apps_bind = {
    { { modkey, "Shift" }, "b", "brave" },
    { { modkey }, "space", "rofimoji --action copy" },
    { { modkey, "Shift" }, "space", "rofimoji --action copy-unicode" },
    { {}, "Print", "flameshot gui" },
  }

  local shell_apps_bind = {
    { { modkey, "Control" }, "b", "wallpaper-random" },
    { { modkey, "Shift" }, "k", "killall screenkey || screenkey -p fixed -g 20%x6%-1%-1% -t 0.5" },
    { { modkey }, "Print", "screenshot-rect.sh" },
  }

  for _, bind in pairs(apps_bind) do
    globalkeys = gears.table.join(
      globalkeys,
      awful.key(bind[1], bind[2], function()
        awful.spawn(bind[3])
      end, {
        description = "launch " .. bind[3],
        group = "applications",
      })
    )
  end

  for _, bind in pairs(shell_apps_bind) do
    globalkeys = gears.table.join(
      globalkeys,
      awful.key(bind[1], bind[2], function()
        awful.spawn.with_shell(bind[3])
      end, {
        description = "launch " .. bind[3],
        group = "applications",
      })
    )
  end

  -- widget mapping
  local brightness_widget = require "awesome-wm-widgets.brightness-widget.brightness"

  globalkeys = gears.table.join(
    globalkeys,
    awful.key({}, "XF86MonBrightnessUp", function()
      brightness_widget:inc()
    end, {
      description = "increase brightness",
      group = "custom",
    }),

    awful.key({}, "XF86MonBrightnessDown", function()
      brightness_widget:dec()
    end, {
      description = "decrease brightness",
      group = "custom",
    }),

    awful.key({ modkey, "Shift" }, "equal", function()
      brightness_widget:inc()
    end, {
      description = "increase brightness",
      group = "custom",
    }),

    awful.key({ modkey, "Shift" }, "minus", function()
      brightness_widget:dec()
    end, {
      description = "decrease brightness",
      group = "custom",
    }),
    awful.key({}, "XF86AudioLowerVolume", function()
      volume_widget:dec()
    end),
    awful.key({}, "XF86AudioRaiseVolume", function()
      volume_widget:inc()
    end),
    awful.key({}, "XF86AudioMute", function()
      volume_widget:toggle()
    end),
    awful.key({ modkey, "Control" }, "minus", function()
      volume_widget:dec()
    end),
    awful.key({ modkey, "Control" }, "equal", function()
      volume_widget:inc()
    end),
    awful.key({ modkey, "Control", "Shift" }, "equal", function()
      volume_widget:toggle()
    end)
  )

  clientkeys = gears.table.join(
    awful.key({ modkey, "Control" }, "t", function(c)
      awful.titlebar.toggle(c)
    end, {
      description = "focus next by index",
      group = "client",
    }),
    awful.key({ modkey, "Shift" }, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, {
      description = "toggle fullscreen",
      group = "client",
    }),
    awful.key({ modkey }, "q", function(c)
      c:kill()
    end, { description = "close", group = "client" }),
    awful.key({ modkey }, "f", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),
    awful.key({ "Mod1" }, "Return", function(c)
      c:swap(awful.client.getmaster())
    end, {
      description = "move to master",
      group = "client",
    }),
    awful.key({ modkey, "Shift" }, "s", function(c)
      c:move_to_screen()
    end, {
      description = "move to screen",
      group = "client",
    }),
    awful.key({ modkey }, "t", function(c)
      c.ontop = not c.ontop
    end, {
      description = "toggle keep on top",
      group = "client",
    }),
    awful.key({ modkey }, "i", function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end, {
      description = "minimize",
      group = "client",
    }),
    awful.key({ modkey }, "m", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, {
      description = "(un)maximize",
      group = "client",
    }),
    awful.key({ modkey, "Control" }, "m", function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end, {
      description = "(un)maximize vertically",
      group = "client",
    }),
    awful.key({ modkey, "Shift" }, "m", function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end, {
      description = "(un)maximize horizontally",
      group = "client",
    })
  )

  root.keys(globalkeys)
end

return {
  setup = setup,
}
