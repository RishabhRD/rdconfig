local colorscheme = require("rd.colors").colorscheme

vim.g.tokyonight_style = "night"
vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_sign_column = "bg0"
vim.g.material_style = "deep ocean"
colorscheme "ayu"

require("lsp-colors").setup {
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981",
}
