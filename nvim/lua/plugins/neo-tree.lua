return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  keys = {
    {
      "<C-n>",
      ":Neotree toggle<CR>",
    },
    {
      "<C-f>",
      ":Neotree reveal<CR>",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      options = {
        theme = "everforest",
        disabled_filetypes = {
          statusline = {
            "neo-tree*",
            "NvimTree",
          },
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          always_show = {
            ".gitignore",
          },
          -- remains hidden even if visible is toggled to true, this overrides always_show
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
    })
  end,
}
