-- Automatically run :PackerSync whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
})

require("packer").startup(function(use)
  -- package manager
  use("wbthomason/packer.nvim")

  -- color themes
  use("sainnhe/everforest")

  -- regular plugins
  use("f-person/auto-dark-mode.nvim")
  use("folke/trouble.nvim")
  use("hrsh7th/vim-vsnip")
  use("jose-elias-alvarez/null-ls.nvim")
  use("jose-elias-alvarez/typescript.nvim")
  use("joosepalviste/nvim-ts-context-commentstring")
  use("jremmen/vim-ripgrep")
  use("kdheepak/lazygit.nvim")
  use("lewis6991/gitsigns.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("mhartington/formatter.nvim")
  use("neovim/nvim-lspconfig")
  use("numtostr/comment.nvim")
  use("nvim-lua/plenary.nvim")
  use("nvim-lualine/lualine.nvim")
  use("psliwka/vim-smoothie")
  use("raimondi/delimitmate")
  use("rishabhrd/nvim-lsputils")
  use("rishabhrd/popfix")
  use("tmhedberg/matchit")
  use("tpope/vim-endwise")
  use("tpope/vim-fugitive")
  use("tpope/vim-liquid")
  use("tpope/vim-repeat")
  use("tpope/vim-rhubarb")
  use("tpope/vim-surround")
  use({
    "williamboman/mason.nvim",
    { "whoissethdaniel/mason-tool-installer.nvim", requires = "mason.nvim" },
  })
  use({
    "hrsh7th/nvim-cmp",
    { "hrsh7th/cmp-buffer", requires = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp", requires = "nvim-cmp" },
    { "hrsh7th/cmp-vsnip", requires = "nvim-cmp" },
  })
  use({
    "nvim-tree/nvim-tree.lua",
    { "nvim-tree/nvim-web-devicons", requires = "nvim-tree.lua" },
  })
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.x",
  })
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })
end)
