-- A minimalist plugin that auto pairs & closes brackets

return {
  "m4xshen/autoclose.nvim",
  config = function()
    require("autoclose").setup()
  end,
}
