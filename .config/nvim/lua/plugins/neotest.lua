return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-plenary",
    },
    config = function()
      local neotest = require "neotest"
      neotest.setup {}

      vim.keymap.set("n", "<leader>tr", function()
        neotest.run.run()
      end)
    end,
  },
}
