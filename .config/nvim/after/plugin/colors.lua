local load_my_colors = require("rd.colors").my_default_config

vim.cmd [[let ayucolor="dark"]]
vim.g.material_style = "deep ocean"

vim.g.tokyonight_style = "night"
vim.g.tokyodark_enable_italic_comment = false
vim.g.tokyodark_enable_italic = false

vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_sign_column = "bg0"
vim.g.gruvbox_invert_selection = "0"
vim.g.gruvbox_bold = "0"

vim.g.material_style = "deep ocean"
require("gruvbox").setup {
  undercurl = true,
  underline = true,
  bold = false,
  italic = {
    strings = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
}
load_my_colors()
