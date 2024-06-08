local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- color themes
  "sainnhe/everforest",

  -- regular plugins
  "elentok/format-on-save.nvim",
  "f-person/auto-dark-mode.nvim",
  "folke/trouble.nvim",
  "folke/noice.nvim",
  "hrsh7th/vim-vsnip",
  "joosepalviste/nvim-ts-context-commentstring",
  "jremmen/vim-ripgrep",
  "lewis6991/gitsigns.nvim",
  "lukas-reineke/indent-blankline.nvim",
  -- "ms-jpq/coq_nvim",
  "MunifTanjim/nui.nvim",
  "numtostr/comment.nvim",
  "numtostr/fterm.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-lualine/lualine.nvim",
  "psliwka/vim-smoothie",
  "raimondi/delimitmate",
  "rcarriga/nvim-notify",
  "rishabhrd/nvim-lsputils",
  "rishabhrd/popfix",
  "tmhedberg/matchit",
  "tpope/vim-endwise",
  "tpope/vim-fugitive",
  "tpope/vim-liquid",
  "tpope/vim-repeat",
  "tpope/vim-rhubarb",
  "tpope/vim-surround",
  "xiyaowong/transparent.nvim",
  {
    "neovim/nvim-lspconfig",
    version = "v0.1.7",
  },
  {
    "williamboman/mason.nvim",
    {
      "whoissethdaniel/mason-tool-installer.nvim",
      dependencies = "mason.nvim",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    {
      "hrsh7th/cmp-buffer",
      dependencies = "nvim-cmp",
    },
    {
      "hrsh7th/cmp-nvim-lsp",
      dependencies = "nvim-cmp",
    },
    {
      "hrsh7th/cmp-vsnip",
      dependencies = "nvim-cmp",
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    {
      "nvim-tree/nvim-web-devicons",
      dependencies = "nvim-tree.lua",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
})
