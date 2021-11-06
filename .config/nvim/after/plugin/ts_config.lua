local custom_captures = {
  ["function.call"] = "LuaFunctionCall",
  ["function.bracket"] = "Type",
  ["namespace.type"] = "TSNamespaceType",
}

require("nvim-treesitter.configs").setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    use_languagetree = false,
    custom_captures = custom_captures,
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["as"] = "@scopename.outer",
        ["is"] = "@scopename.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
      },
      indent = {
        enable = true,
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>an"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>ap"] = "@parameter.inner",
      },
    },
  },
  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = true,
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",

      -- This shows stuff like literal strings, commas, etc.
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
  context_commentstring = {
    config = {
      c = "// %s",
      cpp = "// %s",
      lua = "-- %s",
    },
    enable = true,
    enable_autocmd = false,
  },
}

vim.cmd [[highlight IncludedC guibg=#373b41]]

vim.cmd [[nnoremap <leader>tp :TSPlaygroundToggle<CR>]]
vim.cmd [[nnoremap <leader>th :TSHighlightCapturesUnderCursor<CR>]]
