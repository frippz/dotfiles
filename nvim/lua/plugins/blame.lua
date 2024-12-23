-- blame.nvim is a fugitive.vim style git blame visualizer for Neovim.

return {
  "FabijanZulj/blame.nvim",

  lazy = false,

  keys = {
    {
      "<Leader>gb",
      ":BlameToggle<CR>",
      desc = "Git blame view",
    },
    {
      "<Leader>gbv",
      ":BlameToggle virtual<CR>",
      desc = "Git blame view (inline)",
    },
  },

  config = function()
    require("blame").setup({
      date_format = "%Y-%m-%d %H:%M",
    })
  end,
}
