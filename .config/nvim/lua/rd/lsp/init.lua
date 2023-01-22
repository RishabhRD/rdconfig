local map_tele = require "rd.telescope.mapper"
local lsp = require "lspconfig"
local lspactions = require "lspactions"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local nnoremap = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts)
end

local vnoremap = function(lhs, rhs, opts)
  vim.keymap.set("v", lhs, rhs, opts)
end

local inoremap = function(lhs, rhs, opts)
  vim.keymap.set("i", lhs, rhs, opts)
end

local map = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true })
end

local buf_inoremap = function(lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = 0
  inoremap(lhs, rhs, opts)
end

local buf_nnoremap = function(lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = 0
  nnoremap(lhs, rhs, opts)
end

local buf_vnoremap = function(lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = 0
  vnoremap(lhs, rhs, opts)
end

local function curry1(f, arg)
  return function()
    f(arg)
  end
end

local custom_attach = function(client, buffer)
  map_tele("gr", "lsp_references", nil, true)
  buf_nnoremap("gd", vim.lsp.buf.definition)
  map_tele("gw", "lsp_document_symbols", nil, true)
  map_tele("gW", "lsp_dynamic_workspace_symbols", nil, true)
  map_tele("<leader>ad", "lsp_document_diagnostics")
  map_tele("<leader>aD", "lsp_workspace_diagnostics")
  buf_nnoremap("<leader>af", vim.lsp.buf.code_action)
  buf_vnoremap("<leader>af", vim.lsp.buf.code_action)
  buf_nnoremap("K", vim.lsp.buf.hover)
  buf_inoremap("<C-s>", vim.lsp.buf.signature_help)
  buf_nnoremap("<leader>gt", vim.lsp.buf.type_definition)
  buf_nnoremap("<leader>ar", vim.lsp.buf.rename)
  buf_nnoremap("<leader>aI", vim.lsp.buf.incoming_calls)
  buf_nnoremap("<leader>aO", vim.lsp.buf.outgoing_calls)
  buf_nnoremap("<leader>ee", lspactions.diagnostic.show_line_diagnostics)
  buf_nnoremap("<leader>ec", lspactions.diagnostic.show_position_diagnostics)
  buf_nnoremap("<leader>f=", curry1(vim.lsp.buf.format, { async = true }))
  map("n", "<leader>en", [[m'<cmd>lua require'lspactions'.diagnostic.goto_next()<CR>]])
  map("n", "<leader>ep", [[m'<cmd>lua require'lspactions'.diagnostic.goto_prev()<CR>]])
  if client.server_capabilities["codeLensProvider"] then
    local augroup_name = "CODELENS" .. buffer
    local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      buffer = buffer,
      group = group,
    })

    vim.lsp.codelens.refresh()
    buf_nnoremap("<leader>ac", vim.lsp.codelens.run)
  end
end

local servers = {
  -- ccls = {
  --   init_options = {
  --     clang = {
  --       extraArgs = { "-std=c++2a" },
  --     },
  --   },
  -- },
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      -- "--completion-style=detailed",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
    init_options = {
      fallbackFlags = { "-std=c++2a" },
    },
    on_attach = function()
      map("n", "<leader>hh", "<cmd>ClangdSwitchSourceHeader<CR>")
    end,
  },
  sumneko_lua = {
    cmd = { string.format("%s/git/lua-language-server/bin/lua-language-server", os.getenv "HOME") },
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
  rust_analyzer = {},
  vimls = {},
  tsserver = {},
  html = {},
  cssls = {},
  hls = {
    settings = {
      haskell = {
        hlintOn = true,
        formattingProvider = "stylish-haskell",
      },
    },
  },
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
    config.on_attach = function(client)
      func(client)
      custom_attach(client)
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

local loc_jump_config = {
  open_list = true,
  jump_to_result = true,
}
vim.lsp.handlers["textDocument/references"] = vim.lsp.with(lspactions.references, loc_jump_config)
vim.lsp.handlers["textDocument/definition"] = vim.lsp.with(lspactions.definition, loc_jump_config)
vim.lsp.handlers["textDocument/declaration"] = vim.lsp.with(lspactions.declaration, loc_jump_config)
vim.lsp.handlers["textDocument/implementation"] = vim.lsp.with(lspactions.implementation, loc_jump_config)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = false,
})

vim.cmd [[command! DiagToggle lua require'rd.lsp.diag_toggle'()]]
