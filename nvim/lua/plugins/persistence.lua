-- Simple session management for Neovim

return {
  "folke/persistence.nvim",

  event = "BufReadPre",

  keys = {
    {
      "<Leader>sr",
      ":lua require('persistence').load()<cr>",
      desc = "Load the session for the current directory",
    },
  },

  config = function()
    require("persistence").setup({})
  end,
}
