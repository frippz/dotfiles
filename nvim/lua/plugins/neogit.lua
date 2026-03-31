return {
  "NeogitOrg/neogit",

  lazy = true,

  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "esmuellert/codediff.nvim", -- optional
    "m00qek/baleia.nvim", -- optional
    "folke/snacks.nvim", -- optional
  },

  cmd = "Neogit",

  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  },
}
