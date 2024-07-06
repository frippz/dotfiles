return {
  "rcarriga/nvim-notify",

  config = function()
    require("notify").setup({
      background_colour = "#000000",
      timeout = 2000,
      top_down = false,
      render = "wrapped-compact",
    })
  end,
}
