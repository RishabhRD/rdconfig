local function nmap(expr, callback, opts)
  vim.keymap.set("n", expr, callback, opts)
end

local function vmap(expr, callback, opts)
  vim.keymap.set("v", expr, callback, opts)
end

local function nsmap(expr, callback)
  nmap(expr, callback, { silent = true })
end

local function vsmap(expr, callback)
  vmap(expr, callback, { silent = true })
end

local function execute()
  if vim.bo.filetype == "lua" then
    local line = vim.api.nvim_get_current_line()
    local func = load(line)
    if func then
      func()
    else
      P("Invalid lua: " .. line)
    end
  else
    vim.cmd(vim.api.nvim_get_current_line())
  end
end

local function save_and_execute()
  vim.cmd [[silent! write]]
  if vim.bo.filetype == "vim" then
    vim.cmd [[source %]]
  else
    vim.cmd [[luafile %]]
  end
end

local function setup()
  nmap("<leader><leader>x", save_and_execute)
  nmap("<leader>x", execute)
  nsmap("<leader>r", ":set hlsearch!<CR>")
  vsmap("cp", '"+y')
  nsmap("cp", '"+y')
  nsmap("cpp", '"+yy')
  vsmap("zp", '"+p')
  vsmap("zP", '"+P')
  nsmap("zp", '"+p')
  nsmap("zP", '"+P')
  vsmap("<leader>p", '"_dP')
  vim.keymap.set("t", ",,", [[<C-\><C-n>]], { silent = true })
  vsmap("<C-r>", '"hy:%s/<C-r>h/')
  nmap("k", [[(v:count >= 3 ? "m'" . v:count : "") . 'k']], { silent = true, expr = true })
  nmap("j", [[(v:count >= 3 ? "m'" . v:count : "") . 'j']], { silent = true, expr = true })
  nmap("<leader><leader>n", ":normal!<space>")
  nmap("<leader><leader>c", ":<up>")
  nmap("<leader>sws", [[:%s/\s\+$//<CR>]])
  vim.keymap.set("i", "<C-x><C-x>", "<C-x><C-f>")

  nsmap("<leader>ee", vim.diagnostic.open_float)
  nsmap("<leader>ec", function()
    vim.diagnostic.open_float { scope = "c" }
  end)
  nsmap("<leader>en", function()
    vim.diagnostic.jump { count = 1 }
  end)
  nsmap("<leader>ep", function()
    vim.diagnostic.jump { count = -1 }
  end)
  nsmap("<C-j>", ":cnext<CR>")
  nsmap("<C-k>", ":cprev<CR>")
end

return {
  setup = setup,
}
