-- Tabs, as understood by any other editor.

return {
  "romgrk/barbar.nvim",

  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  keys = {
    { "gt", "<cmd>BufferNext<cr>", desc = "Go to next buffer" },
    { "gT", "<cmd>BufferPrevious<cr>", desc = "Go to previous buffer" },
    { "<Leader>bc", "<cmd>BufferClose<cr>", desc = "Close buffer" },
  },

  init = function()
    vim.g.barbar_auto_setup = false
  end,

  opts = {},

  version = "^1.0.0",
}
