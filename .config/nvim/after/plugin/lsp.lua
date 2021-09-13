local inoremap = vim.keymap.inoremap
local nnoremap = vim.keymap.nnoremap
local map_tele = require "rd.telescope.mapper"
local lsp = require "lspconfig"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local map = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true })
end

local buf_inoremap = function(opts)
  opts.buffer = 0
  inoremap(opts)
end

local buf_nnoremap = function(opts)
  opts.buffer = 0
  nnoremap(opts)
end

local custom_attach = function(_)
  nnoremap { "<leader>R", "<cmd>LspRestart<CR>" }
  map_tele("gr", "lsp_references", nil, true)
  buf_nnoremap { "gd", vim.lsp.buf.definition }
  buf_nnoremap { "gD", vim.lsp.buf.declaration }
  buf_nnoremap { "gi", vim.lsp.buf.implementation }
  map_tele("gw", "lsp_document_symbols", nil, true)
  map_tele("gW", "lsp_dynamic_workspace_symbols", nil, true)
  map_tele("<leader>ad", "lsp_document_diagnostics")
  map_tele("<leader>aD", "lsp_workspace_diagnostics")
  map("v", "af", "<cmd>Telescope lsp_range_code_actions<CR>")
  buf_nnoremap { "K", vim.lsp.buf.hover }
  buf_inoremap { "<C-s>", vim.lsp.buf.signature_help }
  buf_nnoremap { "<leader>gt", vim.lsp.buf.type_definition }
  buf_nnoremap { "<leader>af", vim.lsp.buf.code_action }
  buf_nnoremap { "<leader>ar", vim.lsp.buf.rename }
  buf_nnoremap { "<leader>aI", vim.lsp.buf.incoming_calls }
  buf_nnoremap { "<leader>aO", vim.lsp.buf.outgoing_calls }
  buf_nnoremap { "<leader>ee", vim.lsp.diagnostic.show_line_diagnostics }
  buf_nnoremap { "<leader>ec", vim.lsp.diagnostic.show_position_diagnostics }
  map("n", "<leader>en", [[m'<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]])
  map("n", "<leader>ep", [[m'<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]])
end

local servers = {
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--completion-style=detailed",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
    init_options = {
      fallbackFlags = { "-std=c++17" },
    },
    on_attach = function()
      map("n", "<leader>sH", "<cmd>ClangdSwitchSourceHeader<CR>")
    end,
  },
  sumneko_lua = {
    cmd = { "/usr/bin/lua-language-server" },
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = { "vim" },
        },
      },
    },
  },

  -- ccls = {},
  vimls = {},
  tsserver = {},
  html = {},
  cssls = {},
  texlab = {
    settings = {
      texlab = {
        build = {
          onSave = true,
        },
      },
    },
  },
}

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local function setup_server(server, config)
  if not config then
    return
  end
  if type(config) ~= "table" then
    config = {}
  end
  if config.on_attach then
    local func = config.on_attach
    config.on_attach = function()
      func()
      custom_attach()
    end
  else
    config.on_attach = custom_attach
  end
  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 50,
    },
  }, config)
  lsp[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

-- configuring diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})
