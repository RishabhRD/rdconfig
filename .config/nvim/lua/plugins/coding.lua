local nmap = require("std").nmap
local vmap = require("std").vmap

vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = "v1" },
})

require("mason").setup({})
require("mason-lspconfig").setup({})

local formatter = require("conform")
formatter.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    swift = { lsp_format = "prefer" },
    cpp = { "clang-format", lsp_format = "fallback" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
})
nmap("<leader>=", formatter.format)
vmap("<leader>=", formatter.format)

require("blink.cmp").setup({
  completion = {
    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },
  },
})
local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", { capabilities = lsp_capabilities })
vim.lsp.config("sourcekit", {
  capablities = vim.tbl_extend("force", lsp_capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  }),
})
vim.lsp.enable("sourcekit", true)

nmap("<leader>gce", function()
  vim.lsp.codelens.enable(true, { buffer = 0 })
  print("Enabled codelens for current buffer.")
end)
nmap("<leader>gcd", function()
  vim.lsp.codelens.enable(false, { buffer = 0 })
  print("Disabled codelens for current buffer.")
end)
nmap("<leader>gcr", function()
  vim.lsp.codelens.run({})
end)
