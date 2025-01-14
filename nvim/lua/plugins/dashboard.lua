return {
  "nvimdev/dashboard-nvim",

  dependencies = { "nvim-tree/nvim-web-devicons" },

  event = "VimEnter",

  config = function()
    require("dashboard").setup({
      theme = "doom",
      config = {
        header = {
          "",
          "",
          " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
          " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
          " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
          " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
          " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
          " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
          "",
          "",
        },
        center = {
          {
            icon = "♻️  ",
            icon_hl = "Title",
            desc = "Restore previous session",
            desc_hl = "String",
            key = "r",
            key_hl = "Number",
            key_format = " %s", -- remove default surrounding `[]`
            action = "lua require('persistence').load()",
          },
          {
            icon = "💤 ",
            icon_hl = "Title",
            desc = "Lazy",
            desc_hl = "String",
            key = "l",
            key_hl = "Number",
            key_format = " %s", -- remove default surrounding `[]`
            action = "Lazy",
          },
          {
            icon = "⚙️  ",
            icon_hl = "Title",
            desc = "Mason",
            desc_hl = "String",
            key = "m",
            key_hl = "Number",
            key_format = " %s", -- remove default surrounding `[]`
            action = "Mason",
          },
          {
            icon = "🔭 ",
            icon_hl = "Title",
            desc = "Telescope",
            desc_hl = "String",
            key = "t",
            key_hl = "Number",
            key_format = " %s", -- remove default surrounding `[]`
            action = "Telescope",
          },
        },
        -- footer = { "footer" },
      },
    })
  end,
}
