nvimCmd("syntax enable")
nvimCmd("highlight! link SignColumn LineNr")
nvimCmd("hi Normal guibg=NONE ctermbg=NONE")
nvimCmd("highlight Comment cterm=italic gui=italic")
g.everforest_transparent_background = 1

-- Dark
function ThemeDark()
  o.background = "dark"
  vim.cmd.colorscheme("everforest")
end

-- Light
function ThemeLight()
  o.background = "light"
  vim.cmd.colorscheme("everforest")
end

-- Fallback: set theme based on $TERM_THEME
if vim.fn.has("Linux") then
  if vim.env.TERM_THEME == "light" then
    ThemeLight()
  else
    ThemeDark()
  end
end
