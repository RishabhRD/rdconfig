return {
  "tpope/vim-surround",
  "tpope/vim-scriptease",
  "romainl/vim-qf",
  "lambdalisue/vim-protocol",
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("image").setup {
        processor = "magick_cli",
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
      }
    end,
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        window = {
          backdrop = 0.999,
          height = 0.9,
          width = 140,
          options = {
            number = false,
            relativenumber = false,
          },
        },
      }
    end,
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {}
    end,
  },
  "tpope/vim-repeat",
  "godlygeek/tabular",
  "vim-utils/vim-man",
  -- {
  --   "xeluxee/competitest.nvim",
  --   config = function()
  --     require "rd.compitest"
  --   end,
  -- },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>un", vim.cmd.UndotreeToggle)
    end,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    priority = 100,
    opts = {
      input = {
        title_pos = "center",
        relative = "editor",
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
            ["k"] = "HistoryPrev",
            ["j"] = "HistoryNext",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<C-p>"] = "HistoryPrev",
            ["<C-n>"] = "HistoryNext",
          },
        },
      },
      select = {
        telescope = require("telescope.themes").get_dropdown {
          initial_mode = "normal",
        },
      },
    },
  },
}
