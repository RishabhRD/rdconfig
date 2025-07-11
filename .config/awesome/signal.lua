local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local function setup()
  tag.connect_signal("property::selected", function(t)
    if not t.selected then
      local s = t.screen
      if t ~= previous_tags[s] then
        previous_tags[s] = t
      end
    end
  end)

  -- Signal function to execute when a new client appears.
  client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end)

  -- Add a titlebar if titlebars_enabled is set to true in the rules.
  client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
      awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", { raise = true })
        awful.mouse.client.move(c)
      end),
      awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", { raise = true })
        awful.mouse.client.resize(c)
      end)
    )

    awful.titlebar(c):setup {
      { -- Left
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout = wibox.layout.fixed.horizontal,
      },
      { -- Middle
        { -- Title
          align = "center",
          widget = awful.titlebar.widget.titlewidget(c),
        },
        buttons = buttons,
        layout = wibox.layout.flex.horizontal,
      },
      { -- Right
        awful.titlebar.widget.floatingbutton(c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton(c),
        awful.titlebar.widget.ontopbutton(c),
        awful.titlebar.widget.closebutton(c),
        layout = wibox.layout.fixed.horizontal(),
      },
      layout = wibox.layout.align.horizontal,
    }
  end)

  -- Enable sloppy focus, so that focus follows mouse.
  client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
  end)

  client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
  end)
  client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
  end)
  -- }}}

  screen.connect_signal("arrange", function(s)
    local max = s.selected_tag.layout.name == "max"
    local only_one = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count
    -- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
    for _, c in pairs(s.clients) do
      if (max or only_one) and not c.floating or c.maximized then
        c.border_width = 0
      else
        c.border_width = beautiful.border_width
      end
    end
  end)
end

return {
  setup = setup,
}
