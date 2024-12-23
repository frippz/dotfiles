-- A task runner and job management plugin for Neovim

return {
  "stevearc/overseer.nvim",

  keys = {
    {
      "<leader>rr",
      "<cmd>OverseerRun<cr>",
      desc = "OverseerRun",
    },
    {
      "<leader>rt",
      "<cmd>OverseerToggle<cr>",
      desc = "OverseerToggle",
    },
  },

  opts = {},
}
