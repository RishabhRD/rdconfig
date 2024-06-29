return {
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "ryanoasis/vim-devicons",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require "rd.telescope.setup"
      require "rd.telescope.mapper"
    end,
  },
}
