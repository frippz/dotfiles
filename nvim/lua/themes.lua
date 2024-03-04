-- Themes
-- ============================================================================
nvimCmd("syntax enable")
nvimCmd("highlight! link SignColumn LineNr")
nvimCmd("hi Normal guibg=NONE ctermbg=NONE")
nvimCmd("highlight Comment cterm=italic gui=italic")
g.everforest_transparent_background = 1

-- Dark
-- ----------------------------------------------------------------------------
function ThemeDark()
  o.background = "dark"
  vim.cmd.colorscheme("everforest")
end

-- Light
-- ----------------------------------------------------------------------------
function ThemeLight()
  o.background = "light"
  vim.cmd.colorscheme("everforest")
end

-- Auto Dark Mode
-- ----------------------------------------------------------------------------
local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
  update_interval = 1000,
  set_dark_mode = function()
    ThemeDark()
  end,
  set_light_mode = function()
    ThemeLight()
  end,
})

auto_dark_mode.init()

-- Theming for Linux
-- Set theme based on $TERM_THEME
-- ----------------------------------------------------------------------------
if vim.fn.has("Linux") then
  if vim.env.TERM_THEME == "light" then
    ThemeLight()
  else
    ThemeDark()
  end
end
