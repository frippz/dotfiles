-- match sign column bg to line numbers
vim.api.nvim_set_hl(0, "SignColumn", { link = "LineNr" })

-- transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })

-- italic comments
vim.api.nvim_set_hl(0, "Comment", { italic = true })

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
if vim.fn.has("linux") then
  if vim.env.TERM_THEME == "light" then
    ThemeLight()
  else
    ThemeDark()
  end
end
