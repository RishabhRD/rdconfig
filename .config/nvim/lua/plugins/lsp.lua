return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "williamboman/mason.nvim",
    },
    config = function()
      require("rd.completion").setup {}
      require("rd.lsp").setup {}
    end,
  },
  { "j-hui/fidget.nvim", opts = {} },
}
