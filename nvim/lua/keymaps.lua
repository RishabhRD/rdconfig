local nmap = require("std").nmap
local nsmap = require("std").nsmap
local vsmap = require("std").vsmap

nsmap("<leader>r", ":set hlsearch!<CR>")
vsmap("cp", '"+y')
nsmap("cp", '"+y')
nsmap("cpp", '"+yy')
vsmap("zp", '"+p')
vsmap("zP", '"+P')
nsmap("zp", '"+p')
nsmap("zP", '"+P')
vim.keymap.set("t", ",,", [[<C-\><C-n>]], { silent = true })
nmap("k", [[(v:count >= 2 ? "m'" . v:count : "") . 'k']], { silent = true, expr = true })
nmap("j", [[(v:count >= 2 ? "m'" . v:count : "") . 'j']], { silent = true, expr = true })
vim.keymap.set("i", "<C-x><C-x>", "<C-x><C-f>")
nsmap("<leader>ee", vim.diagnostic.open_float)
nsmap("<leader>ec", function()
  vim.diagnostic.open_float({ scope = "c" })
end)
nsmap("<C-j>", ":cnext<CR>")
nsmap("<C-k>", ":cprev<CR>")
vim.keymap.set("c", "<C-g>", "<C-f>")
