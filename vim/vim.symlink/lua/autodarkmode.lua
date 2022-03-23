local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
  update_interval = 1000,
  set_dark_mode = function()
    vim.api.nvim_set_option('background', 'dark')
    vim.cmd('syntax enable')
    vim.cmd('colorscheme gruvbox')
    vim.cmd('highlight! link SignColumn LineNr')
    -- Set transparent background
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    -- Italic comments
    vim.cmd('highlight Comment cterm=italic gui=italic')
  end,
  set_light_mode = function()
    vim.api.nvim_set_option('background', 'light')
    vim.cmd('syntax enable')
    vim.cmd('colorscheme onehalflight')
    vim.cmd('highlight! link SignColumn LineNr')
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
  end,
})

auto_dark_mode.init()
