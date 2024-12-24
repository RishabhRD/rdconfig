return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "saghen/blink.cmp",
      {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
      },
    },
    config = function(_, opts, other)
      require("mason").setup {}
      require("rd.lsp").setup(opts)
    end,
  },
  { "j-hui/fidget.nvim", opts = {} },
}
