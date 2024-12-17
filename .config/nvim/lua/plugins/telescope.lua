return {
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "kyazdani42/nvim-web-devicons",
      "kkharji/sqlite.lua",
    },
    config = function()
      require "rd.telescope.setup"
      require "rd.telescope.mapper"
    end,
    lazy = false,
    priority = 101,
  },
}
