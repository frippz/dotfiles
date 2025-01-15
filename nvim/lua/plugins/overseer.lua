-- A task runner and job management plugin for Neovim

return {
  "stevearc/overseer.nvim",

  keys = {
    {
      "<leader>rr",
      "<cmd>OverseerRun<cr>",
      desc = "Overseer Run",
    },
    {
      "<leader>rt",
      "<cmd>OverseerToggle<cr>",
      desc = "Overseer Toggle",
    },
  },

  opts = {},
}
