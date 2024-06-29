return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "vimdoc",
          "javascript",
          "typescript",
          "c",
          "lua",
          "rust",
          "jsdoc",
          "bash",
          "java",
          "cpp",
          "go",
          "haskell",
          "markdown",
          "xml",
        },
        sync_install = false,
        auto_install = true,
        indent = {
          enable = true,
        },

        highlight = {
          enable = true,
          -- additional_vim_regex_highlighting = { "markdown" },
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
      }

      local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      treesitter_parser_config.templ = {
        install_info = {
          url = "https://github.com/vrischmann/tree-sitter-templ.git",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "master",
        },
      }

      vim.treesitter.language.register("templ", "templ")
    end,
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
}
