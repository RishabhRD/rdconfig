vim.cmd [[packadd packer.nvim]]

local function colorscheme_plugins(use)
  use "folke/tokyonight.nvim"
  use "ellisonleao/gruvbox.nvim"
  use "bluz71/vim-nightfly-guicolors"
  use "bluz71/vim-moonfly-colors"
  use "marko-cerovac/material.nvim"
  use "sainnhe/gruvbox-material"
  use "EdenEast/nightfox.nvim"
  use "tiagovla/tokyodark.nvim"
  use "navarasu/onedark.nvim"
  use "Shatur/neovim-ayu"
  use "rktjmp/lush.nvim"
  use "RishabhRD/gruvy"
  use "projekt0n/github-nvim-theme"
  use "overcache/NeoSolarized"
  use "Mofiqul/dracula.nvim"
  use "whatyouhide/vim-gotham"
  use "glepnir/zephyr-nvim"
  use "rebelot/kanagawa.nvim"
  use "olimorris/onedarkpro.nvim"
  use "rose-pine/neovim"
  use "catppuccin/nvim"
end

return require("packer").startup {
  function(use)
    use "RishabhRD/lspactions"
    use "RishabhRD/nvim-qf"
    use "wbthomason/packer.nvim"
    use "folke/todo-comments.nvim"
    use "L3MON4D3/LuaSnip"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "tpope/vim-fugitive"
    use "mbbill/undotree"
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-lua/plenary.nvim"
    use "ryanoasis/vim-devicons"
    use "norcalli/nvim-colorizer.lua"
    use "nvim-lua/popup.nvim"
    use "nvim-telescope/telescope.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "ThePrimeagen/harpoon"
    use "editorconfig/editorconfig-vim"
    use "tpope/vim-scriptease"
    use "lambdalisue/vim-protocol"
    use "folke/zen-mode.nvim"
    use "folke/twilight.nvim"
    use "sindrets/diffview.nvim"
    use "tpope/vim-surround"
    use "tpope/vim-repeat"
    use "godlygeek/tabular"

    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "junegunn/fzf", run = "./install --all" }
    use "junegunn/fzf.vim"
    use "lewis6991/gitsigns.nvim"
    use "onsails/lspkind-nvim"
    use "rcarriga/nvim-notify"
    use "nanotee/luv-vimdocs"
    use "google/vim-searchindex"
    use "numToStr/Comment.nvim"
    use "nvim-lua/lsp_extensions.nvim"
    use "antoinemadec/FixCursorHold.nvim"
    use "p00f/godbolt.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use "saadparwaiz1/cmp_luasnip"
    use "tpope/vim-eunuch"
    use "nvim-telescope/telescope-live-grep-raw.nvim"
    use "vim-utils/vim-man"
    use "junegunn/gv.vim"
    use "tpope/vim-dispatch"
    use {
      "j-hui/fidget.nvim",
      branch = "legacy",
    }

    -- Debugger plugins
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "Pocco81/DAPInstall.nvim"
    use "nvim-telescope/telescope-dap.nvim"
    use "theHamsta/nvim-dap-virtual-text"

    -- Formatting plugins
    use "sbdchd/neoformat"

    -- lsp-zero
    use {
      "VonHeikemen/lsp-zero.nvim",
      branch = "v1.x",
      requires = {
        -- LSP Support
        { "neovim/nvim-lspconfig" }, -- Required
        { "williamboman/mason.nvim" }, -- Optional
        { "williamboman/mason-lspconfig.nvim" }, -- Optional

        -- Autocompletion
        { "hrsh7th/nvim-cmp" }, -- Required
        { "hrsh7th/cmp-nvim-lsp" }, -- Required
        { "hrsh7th/cmp-buffer" }, -- Optional
        { "hrsh7th/cmp-path" }, -- Optional
        { "saadparwaiz1/cmp_luasnip" }, -- Optional
        { "hrsh7th/cmp-nvim-lua" }, -- Optional

        -- Snippets
        { "L3MON4D3/LuaSnip" }, -- Required
        -- { "rafamadriz/friendly-snippets" }, -- Optional
      },
    }

    use {
      "folke/noice.nvim",
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    }
    use "stevearc/dressing.nvim"

    use "xeluxee/competitest.nvim"

    --- Clipboard
    -- use {
    --   "AckslD/nvim-neoclip.lua",
    --   requires = {
    --     { "nvim-telescope/telescope.nvim" },
    --   },
    --   config = function()
    --     require("neoclip").setup()
    --   end,
    -- }

    colorscheme_plugins(use)
  end,
}
