vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.hl.on_yank({ timeout = 50, higroup = "IncSearch" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "swift",
  callback = function()
    vim.opt_local.cindent = true
    vim.opt_local.smartindent = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true

    vim.opt_local.formatoptions:append("r")
    vim.opt_local.formatoptions:append("o")

    vim.opt_local.comments = "s1:/*,mb:*,ex:*/,:///,://,s2:/**"
  end,
})
