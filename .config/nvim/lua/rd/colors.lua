local transparent = false

local function set_custom_highlight()
  vim.cmd [[hi Cursor guifg=white guibg=black]]
  vim.cmd [[hi DiagnosticError guifg=#db4b4b]]
  vim.cmd [[hi DiagnosticWarn guifg=#e0af68]]
  vim.cmd [[hi DiagnosticInfo guifg=#0db9d7]]
  vim.cmd [[hi DiagnosticHint guifg=#10B981]]
end

local function colorscheme(str)
  vim.cmd(string.format("colorscheme %s", str))
  if transparent == true then
    vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
  end
  set_custom_highlight()
end

local function toggle_transparency()
  if transparent == false then
    vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
    vim.cmd [[hi SignColumn guibg=none]]
    vim.cmd [[hi CursorLineNR guibg=None]]
    transparent = true
  else
    vim.o.background = "dark"
    transparent = false
  end
  set_custom_highlight()
end

local function make_transparent()
  vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
  vim.cmd [[hi SignColumn guibg=none]]
  vim.cmd [[hi CursorLineNR guibg=None]]
  transparent = true
end

local function make_opaque()
  vim.o.background = "dark"
  transparent = false
end

local function my_default_config()
  colorscheme "kanagawa"
  vim.cmd [[hi MatchParen guibg=#373737 guifg=#00000]]
end

local function setup()
  my_default_config()
  vim.keymap.set("n", "<leader>ty", toggle_transparency)
  vim.keymap.set("n", "<leader>tr", ":colorscheme randomhue<CR>")
  vim.keymap.set("n", "<leader>td", my_default_config)
end

return {
  toggle_transparency = toggle_transparency,
  colorscheme = colorscheme,
  make_transparent = make_transparent,
  make_opaque = make_opaque,
  my_default_config = my_default_config,
  setup = setup,
}
