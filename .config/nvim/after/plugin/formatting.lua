local autoformat_config = require "rd.autoformat"

local formatting_augroup = vim.api.nvim_create_augroup("FORMATTING", {
  clear = true,
})

local format = function()
  if autoformat_config.is_autoformat_enabled() then
    vim.cmd [[Neoformat]]
    vim.cmd [[%s/\s\+$//e]]
  end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = formatting_augroup,
  pattern = { "*" },
  callback = format,
  desc = "Autoformat the code",
})

vim.cmd [[command! AutoFormatEnable lua require'rd.autoformat'.autoformat_enable()]]
vim.cmd [[command! AutoFormatDisable lua require'rd.autoformat'.autoformat_disable()]]
