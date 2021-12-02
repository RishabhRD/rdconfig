local ls = require "luasnip"
local snippet = ls.snippet

local M = {
  sn = ls.snippet_node,
  isn = ls.indent_snippet_node,
  t = ls.text_node,
  i = ls.insert_node,
  f = ls.function_node,
  c = ls.choice_node,
  d = ls.dynamic_node,
  events = require "luasnip.util.events",
  s = snippet
}

M.make = function(tbl)
  local result = {}
  for k, v in pairs(tbl) do
    table.insert(result, snippet({ trig = k, dscr = v.desc, name = v.name or k }, v))
  end
  return result
end

M.ch = function(tbl)
  return M.c(1, tbl)
end

M.fn = function(fn)
  return M.f(fn, {})
end

return M
