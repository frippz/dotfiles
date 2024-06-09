return {
  "numtostr/fterm.nvim",
  keys = {
    {
      "<Leader>t",
      ":lua require('FTerm').toggle()<CR>",
    },
  },

  config = function()
    require("FTerm").setup({})
  end,
}
