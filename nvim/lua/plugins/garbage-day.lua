-- Garbage collector that stops inactive LSP clients to free RAM

return {
  "Zeioth/garbage-day.nvim",

  dependencies = "neovim/nvim-lspconfig",
  event = "VeryLazy",
}
