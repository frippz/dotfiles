-- Provides a simple and easy way to use the interface for tree-sitter in Neovim
-- and to provide some basic functionality such as highlighting based on it

return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  dependencies = { "virchau13/tree-sitter-astro" },

  config = function()
    ---@diagnostic disable
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "astro",
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
        "tsx",
      },

      auto_install = true,

      highlight = {
        enable = true,
      },
    })
  end,
}
