local nnoremap = vim.keymap.nnoremap
local formatter = require "rd.formatter"

nnoremap {
  "<leader>=",
  function()
    formatter.format(vim.bo.filetype)
  end,
}

nnoremap {
  "<leader>f=",
  ":Format<CR>",
  silent = true
}
