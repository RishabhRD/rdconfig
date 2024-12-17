return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.statusline").setup()
      -- require("mini.cursorword").setup { delay = 200 } // highlights current word
      require("mini.indentscope").setup()
    end,
  },
}
