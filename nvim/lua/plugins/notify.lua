-- A fancy, configurable, notification manager for NeoVim

return {
  "rcarriga/nvim-notify",

  config = function()
    require("notify").setup({
      background_colour = "#000000",
      timeout = 2000,
      render = "wrapped-compact",
    })
  end,
}
