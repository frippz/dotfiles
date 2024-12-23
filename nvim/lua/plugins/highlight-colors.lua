-- Highlight colors within Neovim

return {
  "brenoprata10/nvim-highlight-colors",

  config = function()
    require("nvim-highlight-colors").setup({
      render = "virtual",
    })
  end,
}
