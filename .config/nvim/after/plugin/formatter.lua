local formatter = require "rd.formatter"

vim.keymap.set("n", "<leader>=", function()
  formatter.format(vim.bo.filetype)
end)

vim.keymap.set("n", "<leader>f=", ":Format<CR>", {
  silent = true,
})
