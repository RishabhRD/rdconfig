vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd vimball]]

local function colorscheme_plugins(use)
  use "ayu-theme/ayu-vim"
  use "folke/tokyonight.nvim"
  use "gruvbox-community/gruvbox"
  use "bluz71/vim-nightfly-guicolors"
  use "bluz71/vim-moonfly-colors"
  use "marko-cerovac/material.nvim"
  use "sainnhe/gruvbox-material"
  use "EdenEast/nightfox.nvim"
  use "Pocco81/Catppuccino.nvim"
  use "tiagovla/tokyodark.nvim"
  use "navarasu/onedark.nvim"
end

return require("packer").startup {
  function(use)
    use "RishabhRD/lspactions"
    use "RishabhRD/nvim-qf"
    use "wbthomason/packer.nvim"
    use "folke/todo-comments.nvim"
    use "hrsh7th/vim-vsnip"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-vsnip"
    use "tpope/vim-fugitive"
    use "tpope/vim-commentary"
    use "mbbill/undotree"
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-lua/plenary.nvim"
    use "NTBBloodbath/galaxyline.nvim"
    use "ryanoasis/vim-devicons"
    use "norcalli/nvim-colorizer.lua"
    use "nvim-lua/popup.nvim"
    use "nvim-telescope/telescope.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "ThePrimeagen/harpoon"
    use "editorconfig/editorconfig-vim"
    -- use "pwntester/octo.nvim"
    use "tpope/vim-scriptease"
    use "lambdalisue/vim-protocol"
    use "folke/zen-mode.nvim"
    use "folke/twilight.nvim"
    use "windwp/nvim-spectre"
    use "sindrets/diffview.nvim"
    use "tpope/vim-surround"
    use "tpope/vim-repeat"
    use "godlygeek/tabular"
    use "tjdevries/astronauta.nvim"
    use "mfussenegger/nvim-dap"
    use {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
    }
    use "Pocco81/DAPInstall.nvim"
    use "nvim-telescope/telescope-dap.nvim"

    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "junegunn/fzf", run = "./install --all" }
    use "junegunn/fzf.vim"
    use "lewis6991/gitsigns.nvim"
    use "onsails/lspkind-nvim"

    colorscheme_plugins(use)
  end,
}
