return {
  "hrsh7th/nvim-cmp",
  -- load cmp on Enter
  event = "InsertEnter",
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
}
