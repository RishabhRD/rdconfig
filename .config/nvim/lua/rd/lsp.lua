local map_tele = require "rd.telescope.mapper"
local mapper = require "rd.mapper"

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local function attach_keymaps()
  mapper.buf_nnoremap("gd", vim.lsp.buf.definition)
  mapper.buf_nnoremap("gD", vim.lsp.buf.declaration)
  mapper.buf_nnoremap("K", vim.lsp.buf.hover)
  mapper.buf_nnoremap("<leader>gt", vim.lsp.buf.type_definition)
  mapper.buf_nnoremap("<leader>aI", vim.lsp.buf.incoming_calls)
  mapper.buf_nnoremap("<leader>aO", vim.lsp.buf.outgoing_calls)
  mapper.buf_nnoremap("<leader>f=", function()
    vim.lsp.buf.format { async = true }
  end)
  map_tele("grr", "lsp_references", nil, true)
  map_tele("gW", "lsp_dynamic_workspace_symbols", nil, true)
  map_tele("gO", "lsp_document_symbols", nil, true)
end

local pre_write_hooks = {}
local function executeLspPreWriteHooks()
  for _, v in pairs(pre_write_hooks) do
    v()
  end
end

local function is_codelens_available(bufnr, client)
  if client == nil then
    return false
  end
  local status_ok, codelens_supported = pcall(function()
    return client:supports_method "textDocument/codeLens"
  end)
  if not status_ok or not codelens_supported then
    return false
  end

  local codelens_disabled = {
    -- haskell = true -- Disable codelens for haskell
    swift = true,
  }

  local ft = vim.api.nvim_get_option_value("filetype", {
    buf = bufnr,
  })

  return not codelens_disabled[ft]
end

local function setup_codelens(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  local bufnr = args.buf
  if is_codelens_available(bufnr, client) then
    local augroup_name = "CODELENS" .. bufnr
    local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      callback = function()
        if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_is_valid(bufnr) then
          vim.lsp.codelens.refresh { bufnr = bufnr }
        end
      end,
      buffer = bufnr,
      group = group,
    })

    vim.lsp.codelens.refresh()
    mapper.buf_nnoremap("grc", vim.lsp.codelens.run)
  end
end

local function on_attach(args)
  attach_keymaps()
  setup_codelens(args)
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

local function setup()
  vim.g.rustaceanvim = {
    tools = {},
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "K", function()
          vim.cmd.RustLsp { "hover", "actions" }
        end, { silent = true, buffer = bufnr })
        vim.keymap.set("n", "<leader>E", function()
          vim.cmd.RustLsp { "explainError", "cycle" }
        end, { silent = true, buffer = bufnr })
      end,
      default_settings = {
        ["rust-analyzer"] = {},
      },
    },
    dap = {},
  }
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspAttachConfig", { clear = true }),
    desc = "LSP actions",
    callback = function(event)
      on_attach(event)
    end,
  })

  require("mason-lspconfig").setup {
    handlers = {
      default_setup,
      lua_ls = lua_ls_setup,
      clangd = clang_setup,
      -- rust_analyzer = function() end,
    },
    automatic_enable = {
      exclude = {
        "rust_analyzer",
      },
    },
  }

  require("neotest").setup {
    adapters = {
      require "rustaceanvim.neotest",
      -- require "neotest-swift-testing",
    },
  }

  -- swift
  require("lspconfig").sourcekit.setup {
    capablities = vim.tbl_extend("force", lsp_capabilities, {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    }),
  }
end

return {
  setup = setup,
  executeLspPreWriteHooks = executeLspPreWriteHooks,
}
