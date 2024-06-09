return {
  "f-person/auto-dark-mode.nvim",
  config = function()
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
  end,
}
