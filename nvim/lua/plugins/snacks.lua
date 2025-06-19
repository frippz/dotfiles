return {
  "folke/snacks.nvim",

  priority = 1000,
  lazy = false,

  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },

  keys = {
    {
      "<C-p>",
      ":lua Snacks.picker.files()<cr>",
      desc = "Toggle file picker",
    },
    {
      "<C-f>",
      ":lua Snacks.picker.explorer()<cr>",
      desc = "Toggle file explorer",
    },
    {
      "<C-b>",
      ":lua Snacks.picker.buffers()<cr>",
      desc = "Toggle buffers explorer",
    },
    {
      "<leader>fg",
      ":lua Snacks.picker.grep()<cr>",
      desc = "Toggle search",
    },
  },
}
