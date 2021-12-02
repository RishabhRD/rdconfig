local function no_diag()
end

local all_diag = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})

local diag_hidden = false;

local function toggle_diag()
  if diag_hidden then
    diag_hidden = false
    vim.lsp.handlers["textDocument/publishDiagnostics"] = all_diag
    vim.diagnostic.show()
  else
    diag_hidden = true
    vim.lsp.handlers["textDocument/publishDiagnostics"] = no_diag
    vim.diagnostic.hide()
  end
end

return toggle_diag
