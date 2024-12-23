-- Create key bindings that stick. WhichKey helps you remember your Neovim
-- keymaps, by showing available keybindings in a popup as you type.

return {
  "folke/which-key.nvim",

  event = "VeryLazy",

  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },

  opts = {},
}
