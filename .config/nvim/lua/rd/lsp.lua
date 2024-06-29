local map_tele = require "rd.telescope.mapper"
local mapper = require "rd.mapper"
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local function attach_keymaps()
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
  mapper.buf_nnoremap("<leader>f=", function()
    vim.lsp.buf.format { async = true }
  end)
  map_tele("gr", "lsp_references", nil, true)
  map_tele("gW", "lsp_dynamic_workspace_symbols", nil, true)
  map_tele("gw", "lsp_document_symbols", nil, true)
  map_tele("<leader>ad", "lsp_document_diagnostics")
  map_tele("<leader>aD", "lsp_workspace_diagnostics")
end

local pre_write_hooks = {}
local function executeLspPreWriteHooks()
  for _, v in pairs(pre_write_hooks) do
    v()
  end
end

local codelens_config = {
  haskell = true,
}

local function on_attach(args)
  attach_keymaps()
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client == nil then
    return
  end
  local bufnr = args.buf
  local ft = vim.api.nvim_get_option_value("filetype", {
    buf = bufnr,
  })
  if codelens_config[ft] then
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

local function default_setup(server)
  require("lspconfig")[server].setup {
    capabilities = lsp_capabilities,
  }
end

local function lua_ls_setup()
  require("lspconfig").lua_ls.setup {
    capabilities = lsp_capabilities,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      },
    },
  }
end

local function ts_setup()
  require("lspconfig").tsserver.setup {
    capabilities = lsp_capabilities,
    on_attach = function()
      table.insert(pre_write_hooks, function()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "",
        }
        vim.lsp.buf.execute_command(params)
      end)
    end,
  }
end

local function clang_setup()
  require("lspconfig").clangd.setup {
    capabilities = lsp_capabilities,
    init_options = {
      fallbackFlags = { "-std=c++2b" },
    },
    on_attach = function()
      mapper.buf_nnoremap("<leader>hh", "<cmd>ClangdSwitchSourceHeader<CR>")
    end,
  }
end

local function eslint_setup()
  require("lspconfig").eslint.setup {
    capabilities = lsp_capabilities,
    on_attach = function()
      vim.cmd [[EslintFixAll]]
    end,
  }
end

local function setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspAttachConfig", {}),
    desc = "LSP actions",
    callback = function(event)
      on_attach(event)
    end,
  })

  require("mason-lspconfig").setup {
    handlers = {
      default_setup,
      lua_ls = lua_ls_setup,
      tsserver = ts_setup,
      eslint = eslint_setup,
      clangd = clang_setup,
    },
  }
end

return {
  setup = setup,
  executeLspPreWriteHooks = executeLspPreWriteHooks,
}
