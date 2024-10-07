return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
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
