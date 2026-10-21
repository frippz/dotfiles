return {
  "pmizio/typescript-tools.nvim",

  enabled = true,

  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },

  ft = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
  },

  opts = {
    code_lens = "all",
  },
}
