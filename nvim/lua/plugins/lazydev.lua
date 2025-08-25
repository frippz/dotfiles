-- Faster LuaLS setup for Neovim

return {
  "folke/lazydev.nvim",

  ft = "lua", -- only load on lua files

  opts = {
    library = {
      "conform",
      "lazy.nvim",
      "blink",
      "snacks",
    },
  },
}
