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
      vim.keymap.set("n", "<leader>tf", function()
        neotest.run.run(vim.fn.expand "%")
      end)
      vim.keymap.set("n", "<leader>to", function()
        neotest.output_panel.toggle()
      end)
      local summary_open = false
      vim.keymap.set("n", "<leader>ts", function()
        if summary_open then
          summary_open = false
        else
          neotest.run.run(vim.fn.getcwd())
          summary_open = true
        end
        neotest.summary.toggle()
      end)
    end,
  },
}
