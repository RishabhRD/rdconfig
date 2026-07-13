vim.pack.add({
  "https://github.com/ribru17/bamboo.nvim",
  "https://github.com/catppuccin/nvim",
  "https://github.com/neanias/everforest-nvim",
  "https://github.com/kepano/flexoki-neovim",
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/tahayvr/matteblack.nvim",
  "https://github.com/gthelding/monokai-pro.nvim",
  "https://github.com/shaunsingh/nord.nvim",
  "https://github.com/rose-pine/neovim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/bjarneo/aether.nvim",
  "https://github.com/bjarneo/hackerman.nvim",
  "https://github.com/bjarneo/ethereal.nvim",
  "https://github.com/xero/miasma.nvim",
  "https://github.com/bjarneo/vantablack.nvim",
  "https://github.com/bjarneo/white.nvim",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/EskelinenAntti/omarchy-theme-loader.nvim",
})
vim.cmd([[colorscheme tokyonight-night]])
require("monokai-pro").setup({
  filter = "ristretto",
  override = function()
    return {
      NonText = { fg = "#948a8b" },
      MiniIconsGrey = { fg = "#948a8b" },
      MiniIconsRed = { fg = "#fd6883" },
      MiniIconsBlue = { fg = "#85dacc" },
      MiniIconsGreen = { fg = "#adda78" },
      MiniIconsYellow = { fg = "#f9cc6c" },
      MiniIconsOrange = { fg = "#f38d70" },
      MiniIconsPurple = { fg = "#a8a9eb" },
      MiniIconsAzure = { fg = "#a8a9eb" },
      MiniIconsCyan = { fg = "#85dacc" },
    }
  end,
})
