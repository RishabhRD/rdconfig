return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      -- "saghen/blink.cmp",
      "hrsh7th/cmp-nvim-lsp",
      {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
      },
    },
    config = function()
      require("mason").setup {}
      require("rd.lsp").setup()
    end,
  },
  { "j-hui/fidget.nvim", opts = {} },
}
