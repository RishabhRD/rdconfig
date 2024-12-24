local ls = require "luasnip"
local api = require "rd.snippets.api"
local f = api.fn
local make = api.make
local c = api.ch
local s = api.s

local snippets = {}

snippets = make {
  date = {
    desc = "System Date",
    c {
      f(function()
        return os.date "%d-%m-%Y"
      end),
      f(function()
        return os.date "%Y-%m-%d"
      end),
      f(function()
        return os.date "%Y-%b-%d"
      end),
      f(function()
        return os.date "%Y-%B-%d"
      end),
      f(function()
        return os.date "%d-%b-%Y"
      end),
      f(function()
        return os.date "%d-%B-%Y"
      end),
    },
  },
  time = {
    desc = "System time",
    c {
      f(function()
        return os.date "%H:%M:%S %Z"
      end),
      f(function()
        return os.date "%H:%M:%S %z"
      end),
      f(function()
        return os.date "%H:%M:%S"
      end),
      f(function()
        return os.date "%I:%M:%S %p"
      end),
      f(function()
        return os.date "%I:%M:%S %p %Z"
      end),
      f(function()
        return os.date "%I:%M:%S %p %z"
      end),
    },
  },
  timestamp = {
    desc = "Timestamp",
    c {
      f(function()
        return os.date()
      end),
    },
  },
  week = {
    desc = "Week",
    c {
      f(function()
        return os.date "%a"
      end),
      f(function()
        return os.date "%A"
      end),
      f(function()
        return os.date "%w"
      end),
    },
  },
}

local function bash(_, snip, command)
  if snip.captures[1] then
    command = snip.captures[1]
  end
  local file = io.popen(command, "r")
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end

table.insert(snippets, s({ trig = "$$ (.*)", regTrig = true, hidden = true }, api.f(bash, {}, "ls")))

ls.add_snippets("all", snippets)
