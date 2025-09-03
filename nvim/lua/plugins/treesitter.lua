-- Provides a simple and easy way to use the interface for tree-sitter in Neovim
-- and to provide some basic functionality such as highlighting based on it

return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  config = function()
    ---@diagnostic disable
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "css",
        "diff",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "javascript",
        "jsdoc",
        "lua",
        "markdown",
        "regex",
        "scss",
        "svelte",
        "typescript",
      },

      auto_install = true,

      highlight = {
        enable = true,
      },
    })
  end,
}
