-- A Neovim plugin for macOS, Linux, and Windows that automatically changes the
-- editor appearance based on system settings.

return {
  "f-person/auto-dark-mode.nvim",

  opts = {
    fallback = "light",
    update_interval = 1000,
    set_dark_mode = function()
      ThemeDark()
    end,
    set_light_mode = function()
      ThemeLight()
    end,
  },
}
