-- Manage the file system and other tree like structures

return {
  "nvim-neo-tree/neo-tree.nvim",

  -- disable plugin
  enabled = false,

  branch = "v3.x",

  keys = {
    {
      "<C-n>",
      ":Neotree toggle<CR>",
      desc = "Toggle Neotree",
    },
    {
      "<C-f>",
      ":Neotree reveal<CR>",
      desc = "Reveal file in Neotree",
    },
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  config = function()
    require("neo-tree").setup({
      filesystem = {
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          always_show = {
            ".cursorrules",
            ".gitignore",
            ".env",
            "*.db",
          },
          -- remain hidden even if visible is toggled to true, this overrides always_show
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
    })
  end,
}
