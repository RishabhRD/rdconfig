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

      vim.keymap.set("n", "<leader>tt", function()
        neotest.run.run()
      end)
      vim.keymap.set("n", "<leader>ta", function()
        neotest.run.run(vim.fn.expand "%")
      end)
      vim.keymap.set("n", "<leader>to", function()
        neotest.output_panel.toggle()
      end)
      vim.keymap.set("n", "<leader>ts", function()
        neotest.summary.toggle()
      end)
    end,
  },
}
