local transparent = false

local function set_custom_highlight()
  vim.cmd [[hi netrwDir guifg=#5eacd3]]
  vim.cmd [[hi qfFileName guifg=#aed75f]]
  vim.cmd [[hi DiagnosticError guifg=#db4b4b]]
  vim.cmd [[hi DiagnosticWarn guifg=#e0af68]]
  vim.cmd [[hi DiagnosticInfo guifg=#0db9d7]]
  vim.cmd [[hi DiagnosticHint guifg=#10B981]]
  vim.cmd[[call overlength#set_highlight('darkgrey', '#8b0000')]]
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
    transparent = true
  else
    vim.o.background = "dark"
    transparent = false
  end
  set_custom_highlight()
end


return {
  toggle_transparency = toggle_transparency,
  colorscheme = colorscheme,
}
