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
      -- "permissions",
      -- "size",
      -- "mtime",
    },
  },

  keys = {
    {
      "<Leader>e",
      ":Oil<CR>",
      desc = "Open file explorer (oil.nvim)",
    },
  },
}
