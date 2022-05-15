local autoformat_config = require "rd.autoformat"

local formatting_augroup = vim.api.nvim_create_augroup("FORMATTING", {
  clear = true,
})

local format = function()
  if not autoformat_config.is_autoformat_disabled_globally() then
    if autoformat_config.can_autoformat_buffer(vim.api.nvim_get_current_buf()) then
      vim.cmd [[Neoformat]]
      vim.cmd [[%s/\s\+$//e]]
    end
  end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = formatting_augroup,
  pattern = { "*" },
  callback = format,
  desc = "Autoformat the code",
})

vim.cmd [[command! AutoFormatEnableGlobal lua require'rd.autoformat'.autoformat_enable_global()]]
vim.cmd [[command! AutoFormatDisableGlobal lua require'rd.autoformat'.autoformat_disable_global()]]

-- TODO: look how can we do this with commands
-- vim.cmd(
--   string.format(
--     "command! AutoFormatEnable lua require'rd.autoformat'.autoformat_enable(%d)",
--     vim.api.nvim_get_current_buf()
--   )
-- )
-- vim.cmd(
--   string.format(
--     "command! AutoFormatDisable lua require'rd.autoformat'.autoformat_disable(%d)",
--     vim.api.nvim_get_current_buf()
--   )
-- )

vim.keymap.set("n", "<leader>fd", function()
  autoformat_config.autoformat_disable(vim.api.nvim_get_current_buf())
  print("Autoformat disabled for buffer ", vim.api.nvim_get_current_buf())
end)
vim.keymap.set("n", "<leader>fe", function()
  autoformat_config.autoformat_enable(vim.api.nvim_get_current_buf())
  print("Autoformat enabled for buffer ", vim.api.nvim_get_current_buf())
end)
