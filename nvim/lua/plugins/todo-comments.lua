return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>tt",
      "<cmd>TodoTelescope<cr>",
      desc = "See TODOs in Telescope",
    },
  },
  opts = {
    comments_only = true,
  },
}
