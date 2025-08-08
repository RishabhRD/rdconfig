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
        version = "^6",
        lazy = false,
      },
      -- "mmllr/neotest-swift-testing",
    },
    config = function()
      require("mason").setup {}
      require("rd.lsp").setup()
    end,
  },
  { "j-hui/fidget.nvim", opts = {} },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
