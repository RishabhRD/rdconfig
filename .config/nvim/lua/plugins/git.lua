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
  "lewis6991/gitsigns.nvim",
  "sindrets/diffview.nvim",
  "tpope/vim-eunuch",
  "junegunn/gv.vim",
}
