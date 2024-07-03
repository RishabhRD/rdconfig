return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", ":G<CR>")
      vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>")
      vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>")
      vim.keymap.set("n", "<leader>gc", ":Git commit<CR>")
      vim.keymap.set("n", "<leader>gl", ":GV<CR>")
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require "gitsigns"
      require("gitsigns").setup()
      local map = vim.keymap.set
      map("n", "<leader>hs", gitsigns.stage_hunk)
      map("n", "<leader>hr", gitsigns.reset_hunk)
      map("v", "<leader>hs", function()
        gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
      end)
      map("v", "<leader>hr", function()
        gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
      end)
      map("n", "<leader>hS", gitsigns.stage_buffer)
      map("n", "<leader>hu", gitsigns.undo_stage_hunk)
      map("n", "<leader>hR", gitsigns.reset_buffer)
      map("n", "<leader>hp", gitsigns.preview_hunk)
      map("n", "<leader>hb", function()
        gitsigns.blame_line { full = true }
      end)
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
      map("n", "<leader>hd", gitsigns.diffthis)
      map("n", "<leader>hD", function()
        gitsigns.diffthis "~"
      end)
      map("n", "<leader>td", gitsigns.toggle_deleted)

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
  },
  "lewis6991/gitsigns.nvim",
  "sindrets/diffview.nvim",
  "tpope/vim-eunuch",
  "junegunn/gv.vim",
}
