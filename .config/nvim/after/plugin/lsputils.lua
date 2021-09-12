local codeAction = require "lsputil.codeAction"
local symbols = require "lsputil.symbols"
vim.g.lsp_utils_location_opts = {
  height = 24,
  mode = "editor",
  list = {
    border = true,
    numbering = true,
  },
  preview = {
    title = "Location Preview",
    border = true,
  },
  prompt = {},
}

vim.g.lsp_utils_symbols_opts = {
  height = 24,
  mode = "editor",
  list = {
    border = true,
    numbering = false,
  },
  preview = {
    title = "Symbols Preview",
    border = true,
  },
  prompt = {},
}

vim.lsp.handlers["textDocument/codeAction"] = codeAction.code_action_handler
vim.lsp.handlers["textDocument/documentSymbol"] = symbols.document_handler
vim.lsp.handlers["workspace/symbol"] = symbols.workspace_handler
