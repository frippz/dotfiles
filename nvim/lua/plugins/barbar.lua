return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "gt", "<cmd>BufferNext<cr>", desc = "Go to next buffer" },
    { "gT", "<cmd>BufferPrevious<cr>", desc = "Go to previous buffer" },
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {},
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
}