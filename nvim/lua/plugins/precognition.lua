-- Precognition uses virtual text and gutter signs to show available motions.

return {
  "tris203/precognition.nvim",

  event = "VeryLazy",

  keys = {
    { "<Leader>h", "<cmd>Precognition toggle<cr>", desc = "Toggle Precognition tooltips" },
  },

  opts = {
    startVisible = false,
  },
}
