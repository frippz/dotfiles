return {
  "nvimdev/dashboard-nvim",
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
            icon = "🔄 ",
            icon_hl = "Title",
            desc = "Restore previous session",
            desc_hl = "String",
            key = "b",
            keymap = "R",
            key_hl = "Number",
            key_format = " %s", -- remove default surrounding `[]`
            action = "lua require('persistence').load({ last = true })",
          },
        },
        -- footer = { "footer" },
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
