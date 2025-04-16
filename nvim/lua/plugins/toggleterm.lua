-- A plugin to help easily manage multiple terminal windows

return {
  "akinsho/toggleterm.nvim",

  version = "*",

  keys = {
    {
      "<Leader>t",
      ":ToggleTerm<CR>",
      desc = "Toggle terminal",
    },
  },

  opts = {
    direction = "float",
    float_opts = {
      border = "double",
    },
  },
}
