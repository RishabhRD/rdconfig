local ls = require "luasnip"
local snippet = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local events = require("luasnip.util.events")

local make = function(tbl)
  local result = {}
  for k, v in pairs(tbl) do
    table.insert(result, snippet({ trig = k, dscr = v.desc, name = v.name }, v))
  end
  return result
end

-- TODO: Will check this later
--
-- local function get_snippet_text(val)
--   if type(val) == "string" then
--     return t(val)
--   end
--   local res = {}
--   for _, v in ipairs(val) do
--     table.insert(v)
--   end
--   return t(res)
-- end

-- local t_make = function(tbl)
--   local result = {}
--   for k, v in pairs(tbl) do
--     table.insert(result, snippet({ trig = k, dscr = v.desc, name = v.name }, get_snippet_text(v)))
--   end
--   return result
-- end

local snippets = {}

snippets.all = make {
  date = {
    name = "date",
    desc = "System's date",
    f(function()
      P('here')
      local date_table = os.date "*t"
      local hour, minute, second = date_table.hour, date_table.min, date_table.sec
      local year, month, day = date_table.year, date_table.month, date_table.wday
      local result = string.format("%d-%d-%d %d:%d:%d", year, month, day, hour, minute, second)
      return result
    end, {}),
  },
}

ls.snippets = snippets

vim.cmd [[
  imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  inoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<CR>

  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'

  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<CR>
]]
