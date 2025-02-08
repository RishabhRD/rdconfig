local gears = require "gears"
local wibox = require "wibox"
local awful = require "awful"

local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

local function prompt(screen)
  local box = awful.widget.prompt()
  screen.mypromptbox = box
  return box
end

local function layoutbox(screen)
  local mylayoutbox = awful.widget.layoutbox(screen)
  mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))
  screen.mylayoutbox = mylayoutbox
  return mylayoutbox
end

local function taglist(screen)
  local list = awful.widget.taglist {
    screen = screen,
    filter = function(t)
      return t.selected or #t:clients() > 0
    end,
    buttons = taglist_buttons,
  }
  screen.mytaglist = list
  return list
end

local function tasklist(screen)
  local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
      if c == client.focus then
        c.minimized = true
      else
        c:emit_signal("request::activate", "tasklist", { raise = true })
      end
    end),
    awful.button({}, 3, function()
      awful.menu.client_list { theme = { width = 250 } }
    end),
    awful.button({}, 4, function()
      awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
      awful.client.focus.byidx(-1)
    end)
  )
  local list = awful.widget.tasklist {
    screen = screen,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  }
  screen.mytasklist = list
  return list
end

local function calender(_)
  local calendar_widget = require "awesome-wm-widgets.calendar-widget.calendar"
  local mytextclock = wibox.widget.textclock()
  local cw = calendar_widget {
    theme = "outrun",
    placement = "top_center",
    start_sunday = true,
  }
  mytextclock:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
      cw.toggle()
    end
  end)
  return mytextclock
end

local function github_conribution(_)
  local github_contributions_widget =
    require "awesome-wm-widgets.github-contributions-widget.github-contributions-widget"
  return github_contributions_widget {
    color_of_empty_cells = "#00000000",
    margin_top = 0,
    username = "RishabhRD",
  }
end

local function github_activity(_)
  local github_activity_widget = require "awesome-wm-widgets.github-activity-widget.github-activity-widget"
  return github_activity_widget {
    username = "RishabhRD",
  }
end

local function github_prs(_)
  local github_prs_widget = require "awesome-wm-widgets.github-prs-widget"
  return github_prs_widget {
    reviewer = "RishabhRD",
  }
end

local function cpu(_)
  local cpu_widget = require "awesome-wm-widgets.cpu-widget.cpu-widget"
  return cpu_widget {}
end

local function battery(_)
  local batteryarc_widget = require "awesome-wm-widgets.batteryarc-widget.batteryarc"
  return batteryarc_widget {
    show_notification_mode = "on_click",
    show_current_level = true,
    warning_msg_title = "Rishabh, There is a problem",
    size = 22,
  }
end

local function volume(_)
  local volume_widget = require "awesome-wm-widgets.volume-widget.volume"
  return volume_widget {
    mixer_cmd = terminal .. " -e alsamixer",
  }
end

local function logout_menu(_)
  local logout_menu_widget = require "awesome-wm-widgets.logout-menu-widget.logout-menu"
  return logout_menu_widget()
end

local function ram(_)
  local ram_widget = require "awesome-wm-widgets.ram-widget.ram-widget"
  return ram_widget()
end

local function brightness(_)
  local brightness_widget = require "awesome-wm-widgets.brightness-widget.brightness"
  return brightness_widget {
    step = 5,
    timeout = 1,
  }
end

local function todo(_)
  local todo_widget = require "awesome-wm-widgets.todo-widget.todo"
  return todo_widget()
end

local function setup(s)
  local w = awful.wibar { position = "top", screen = s }

  w:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      taglist(s),
      prompt(s),
      tasklist(s),
    },
    { -- Middle widget
      layout = wibox.layout.align.horizontal,
      calender(s),
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      spacing = 9,
      todo(),
      github_conribution(s),
      github_activity(s),
      github_prs(s),
      cpu(s),
      ram(s),
      volume(s),
      brightness(s),
      battery(s),
      wibox.widget.systray(),
      logout_menu(s),
      awful.widget.keyboardlayout(),
      layoutbox(s),
    },
  }
  s.mywibox = w
end

return {
  setup = setup,
}
