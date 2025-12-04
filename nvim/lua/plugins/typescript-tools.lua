return {
  "pmizio/typescript-tools.nvim",

  enabled = false,

  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },

  filetypes = {
    "typescript",
    "javascript",
    "svelte",
  },

  opts = {
    code_lens = "all",
  },
}
