return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "everforest",
        disabled_filetypes = {
          statusline = {
            "neo-tree",
          },
        },
      },
    })
  end,
}
