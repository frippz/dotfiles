return {
  "rcarriga/nvim-notify",

  config = function()
    require("notify").setup({
      background_colour = "#000000",
      timeout = 3000,
      top_down = false,
    })
  end,
}
