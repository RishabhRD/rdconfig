local function set_custom_highlight()
  vim.cmd [[hi Cursor guifg=white guibg=black]]
  vim.cmd [[hi DiagnosticError guifg=#db4b4b]]
  vim.cmd [[hi DiagnosticWarn guifg=#e0af68]]
  vim.cmd [[hi DiagnosticInfo guifg=#0db9d7]]
  vim.cmd [[hi DiagnosticHint guifg=#10B981]]
end

local function colorscheme(str)
  vim.cmd(string.format("colorscheme %s", str))
  set_custom_highlight()
end

local function my_default_config()
  colorscheme "tokyonight-night"
  -- vim.cmd [[hi MatchParen guibg=#373737 guifg=#00000]]
end

local function setup()
  my_default_config()
  vim.keymap.set("n", "<leader>tr", ":TransparentToggle<CR>")
  vim.keymap.set("n", "<leader>td", my_default_config)
end

return {
  colorscheme = colorscheme,
  my_default_config = my_default_config,
  setup = setup,
}
