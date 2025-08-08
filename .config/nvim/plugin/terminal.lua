-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("term_open", {}),
  callback = function()
    vim.opt_local.nu = true
    vim.opt_local.rnu = true
    vim.opt_local.scrolloff = 0
  end,
})
