return {
  "zerbiniandrea/conventional-commits.nvim",

  cmd = "ConventionalCommit",

  config = function()
    require("conventional-commits").setup({
      show_emoji_step = false,
    })
  end,

  keys = {
    { "<leader>gc", "<cmd>ConventionalCommit<cr>", desc = "Conventional Commit" },
  },
}
