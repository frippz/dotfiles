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
            action = "lua require('persistence').load()",
          },
          {
            icon = "🚀 ",
            icon_hl = "Title",
            desc = "Overseer",
            desc_hl = "String",
            action = "require('overseer').run_template()",
          },
          {
            icon = "💤 ",
            icon_hl = "Title",
            desc = "Lazy",
            desc_hl = "String",
            action = "Lazy",
          },
          {
            icon = "⚙️  ",
            icon_hl = "Title",
            desc = "Mason",
            desc_hl = "String",
            action = "Mason",
          },
          {
            icon = "🔭 ",
            icon_hl = "Title",
            desc = "Telescope",
            desc_hl = "String",
            action = "Telescope",
          },
          {
            icon = "💣 ",
            icon_hl = "Title",
            desc = "Quit",
            desc_hl = "String",
            action = "q",
          },
        },
      },
    })
  end,
}
