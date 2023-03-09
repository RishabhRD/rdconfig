local map_tele = require "rd.telescope.mapper"
local mapper = require "rd.mapper"
local lsp = require "lsp-zero"

local function curry1(f, arg)
  return function()
    f(arg)
  end
end

local preWriteHooks = {}

local function executeLspPreWriteHooks()
  for _, v in pairs(preWriteHooks) do
    v()
  end
end

local on_attach = function(client, bufnr)
  mapper.buf_nnoremap("gd", vim.lsp.buf.definition)
  mapper.buf_nnoremap("gD", vim.lsp.buf.declaration)
  mapper.buf_nnoremap("gi", vim.lsp.buf.implementation)
  mapper.buf_nnoremap("K", vim.lsp.buf.hover)
  mapper.buf_nnoremap("<leader>af", vim.lsp.buf.code_action)
  mapper.buf_vnoremap("<leader>af", vim.lsp.buf.code_action)
  mapper.buf_inoremap("<C-s>", vim.lsp.buf.signature_help)
  mapper.buf_nnoremap("<leader>gt", vim.lsp.buf.type_definition)
  mapper.buf_nnoremap("<leader>ar", vim.lsp.buf.rename)
  mapper.buf_nnoremap("<leader>aI", vim.lsp.buf.incoming_calls)
  mapper.buf_nnoremap("<leader>aO", vim.lsp.buf.outgoing_calls)
  mapper.buf_nnoremap("<leader>ee", vim.diagnostic.open_float)
  mapper.buf_nnoremap("<leader>ec", curry1(vim.diagnostic.open_float, { scope = "c" }))
  mapper.buf_nnoremap("<leader>f=", curry1(vim.lsp.buf.format, { async = true }))
  mapper.buf_nnoremap("<leader>en", vim.diagnostic.goto_next)
  mapper.buf_nnoremap("<leader>ep", vim.diagnostic.goto_prev)
  map_tele("gr", "lsp_references", nil, true)
  map_tele("gW", "lsp_dynamic_workspace_symbols", nil, true)
  map_tele("gw", "lsp_document_symbols", nil, true)
  map_tele("<leader>ad", "lsp_document_diagnostics")
  map_tele("<leader>aD", "lsp_workspace_diagnostics")
  if client.server_capabilities["codeLensProvider"] then
    local augroup_name = "CODELENS" .. bufnr
    local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      buffer = bufnr,
      group = group,
    })

    vim.lsp.codelens.refresh()
    mapper.buf_nnoremap("<leader>ac", vim.lsp.codelens.run)
  end
end

local function typescript_organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

local function configure(name, config)
  config = config or {}
  if config.on_attach then
    local func = config.on_attach
    config.on_attach = function(client, buffer)
      on_attach(client, buffer)
      func(client, buffer)
    end
  end
  lsp.configure(name, config)
end

local function setup()
  lsp.preset "lsp-compe"

  lsp.set_preferences {
    set_lsp_keymaps = false,
  }
  lsp.set_server_config {
    on_attach = on_attach,
  }

  configure("clangd", {
    init_options = {
      fallbackFlags = { "-std=c++2a" },
    },
    on_attach = function()
      mapper.buf_nnoremap("<leader>hh", "<cmd>ClangdSwitchSourceHeader<CR>")
    end,
  })

  configure("eslint", {
    on_attach = function()
      preWriteHooks[2] = function()
        vim.cmd [[EslintFixAll]]
      end
    end,
  })

  configure("tsserver", {
    on_attach = function()
      preWriteHooks[1] = typescript_organize_imports
    end,
    commands = {
      OrganizeImports = {
        typescript_organize_imports,
        description = "Organize Imports",
      },
    },
  })

  -- (Optional) Configure lua language server for neovim
  lsp.nvim_workspace()

  lsp.setup()

  vim.diagnostic.config {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }
end

return {
  setup = setup,
  executeLspPreWriteHooks = executeLspPreWriteHooks,
}
