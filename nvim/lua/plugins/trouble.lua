-- A pretty diagnostics, references, telescope results, quickfix and location
-- list to help you solve all the trouble your code is causing.

return {
  "folke/trouble.nvim",

  cmd = "Trouble",

  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble<cr>",
      desc = "Launch Trouble",
    },
    {
      "<leader>xw",
      "<cmd>Trouble workspace_diagnostics<cr>",
      desc = "Workspace Diagnostics (Trouble)",
    },
    {
      "<leader>xd",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble loclist<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xq",
      "<cmd>Trouble quickfix<cr>",
      desc = "Quickfix List (Trouble)",
    },
    {
      "gR",
      "<cmd>TroubleToggle lsp_references<cr>",
      desc = "LSP references (Trouble)",
    },
  },

  config = function()
    require("trouble").setup({})
  end,
}
