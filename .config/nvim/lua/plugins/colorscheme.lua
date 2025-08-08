return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = require("rd.colors").setup,
  },
  "craftzdog/solarized-osaka.nvim",
  "rebelot/kanagawa.nvim",
  "folke/tokyonight.nvim",
  "Shatur/neovim-ayu",
  "xero/miasma.nvim",
  "kepano/flexoki-neovim",
  "ntk148v/komau.vim",
  { "catppuccin/nvim", name = "catppuccin" },
  { "rose-pine/neovim", name = "rose-pine" },
  "uloco/bluloco.nvim",
  "gruvbox-community/gruvbox",
  "raddari/last-color.nvim",
  "bluz71/vim-nightfly-colors",
  "sainnhe/sonokai",
  {
    "xiyaowong/transparent.nvim",
    config = function()
      -- Optional, you don't have to run setup.
      require("transparent").setup {
        -- table: default groups
        groups = {
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLine",
          "CursorLineNr",
          "StatusLine",
          "StatusLineNC",
          "EndOfBuffer",
        },
        -- table: additional groups that should be cleared
        extra_groups = {},
        -- table: groups you don't want to clear
        exclude_groups = { "CursorLine" },
        -- function: code to be executed after highlight groups are cleared
        -- Also the user event "TransparentClear" will be triggered
        on_clear = function() end,
      }
    end,
  },
  {
    "maxmx03/fluoromachine.nvim",
    -- config = function()
    --   local fm = require "fluoromachine"
    --   fm.setup { glow = true, theme = "fluoromachine" }
    -- end,
  },
}
