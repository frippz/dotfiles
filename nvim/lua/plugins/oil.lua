return {
  "stevearc/oil.nvim",

  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = {
    {
      "nvim-mini/mini.icons",
      opts = {},
    },
  },
  lazy = false,

  opts = {
    columns = {
      "icon",
    },

    float = {
      padding = 2,
      max_width = 0.7,
      max_height = 0.7,
      border = "rounded",
    },
  },

  keys = {
    {
      "<Leader>e",
      ":Oil --float<CR>",
      desc = "Open file explorer (oil.nvim)",
    },
  },
}
