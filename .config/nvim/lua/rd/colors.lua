local transparent = false

local function set_tab_highlight()
  vim.cmd [[hi TabLineFill gui=none guibg=#3d4345]]
  vim.cmd [[hi TabLine gui=none guibg=#3d4345 guifg=#c0c9cc]]
  vim.cmd [[hi TabLineSel gui=bold guifg=#c0c9cc]]
end

local function set_other_highlight()
  vim.cmd [[hi SignColumn guibg=none]]
  vim.cmd [[hi netrwDir guifg=#5eacd3]]
  vim.cmd [[hi qfFileName guifg=#aed75f]]
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
  set_other_highlight()
  set_tab_highlight()
end

local function toggle_transparency()
  if transparent == false then
    vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
    transparent = true
  else
    vim.o.background = "dark"
    transparent = false
  end
  set_tab_highlight()
  set_other_highlight()
end


return {
  toggle_transparency = toggle_transparency,
  colorscheme = colorscheme,
}
