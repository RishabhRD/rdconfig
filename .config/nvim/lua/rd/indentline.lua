vim.g.indent_blankline_enabled = false
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal" }
vim.g.indent_blankline_bufname_exclude = { "README.md" }
vim.g.indent_blankline_use_treesitter = true

vim.keymap.set("n", "<leader>ti", "<Cmd>IndentBlanklineToggle!<CR>")
