return {
  "crispgm/nvim-tabline",

  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    require("tabline").setup({
      show_icon = true,
    })
  end,
}
