vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd vimball]]

local function colorscheme_plugins(use)
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
  use "Shatur/neovim-ayu"
  use "rktjmp/lush.nvim"
  use "RishabhRD/gruvy"
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
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "nvim-lua/plenary.nvim"
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
    use "rcarriga/nvim-notify"
    use "nanotee/luv-vimdocs"
    use "google/vim-searchindex"
    use "numToStr/Comment.nvim"
    use "tjdevries/express_line.nvim"
    use "nvim-lua/lsp-status.nvim"
    use "nvim-lua/lsp_extensions.nvim"
    use "tjdevries/overlength.vim"
    use "antoinemadec/FixCursorHold.nvim"
    use "p00f/godbolt.nvim"
    use "lukas-reineke/indent-blankline.nvim"

    colorscheme_plugins(use)
  end,
}
