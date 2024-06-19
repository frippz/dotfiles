return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  config = function()
    require("persistence").setup({})
  end,
  keys = {
    {
      "<Leader>sr",
      ":lua require('persistence').load({ last = true })<cr>",
    },
  },
}
