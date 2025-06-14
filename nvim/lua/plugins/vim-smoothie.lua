-- vim-smoothie: Smooth scrolling for Vim done right🥤

return {
  "psliwka/vim-smoothie",

  -- disable plugin
  enabled = false,

  init = function()
    vim.g.smoothie_enabled = 1
  end,
}
