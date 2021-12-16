local formatter_table = {
  lua = require("rd.stylua").format,
  cpp = require "rd.formatter.cpp",
}

local function format(lang)
  if formatter_table[lang] then
    formatter_table[lang]()
  else
    if #vim.lsp.buf_get_clients() ~= 0 then
      vim.lsp.buf.formatting()
    end
  end
end

return {
  format = format,
}
