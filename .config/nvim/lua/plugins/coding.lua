local nmap = require("std").nmap
local vmap = require("std").vmap

vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = "v1" },
  { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
})

require("mason").setup({})
require("mason-lspconfig").setup({})
require("tree-sitter-manager").setup({ auto_install = true })

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
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = "rounded",
      },
    },
    menu = {
      border = "rounded",
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

local function add_lsp_keybinds_to_buffer()
  nmap("gd", vim.lsp.buf.definition, { buffer = 0 })
  nmap("gD", vim.lsp.buf.declaration, { buffer = 0 })
  nmap("<leader>f=", function()
    vim.lsp.format({ async = true })
  end)
  nmap("gO", ":Snacks lsp_symbols<CR>", { buffer = 0 })
  nmap("gW", ":Snacks lsp_workspace_symbols<CR>", { buffer = 0 })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttachConfig", { clear = true }),
  desc = "LSP actions",
  callback = add_lsp_keybinds_to_buffer,
})
