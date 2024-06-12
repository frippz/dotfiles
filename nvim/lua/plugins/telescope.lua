return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    lazy = false,
    keys = {
      {
        "<leader>ft",
        ":Telescope<CR>",
      },
      {
        "<C-p>",
        ":Telescope find_files hidden=true<CR>",
      },
      {
        "<C-b>",
        ":Telescope buffers<CR>",
      },
      {
        "<leader>fg",
        ":Telescope live_grep<CR>",
      },
      {
        "<leader>fh",
        ":Telescope help_tags<CR>",
      },
    },
    config = function()
      local telescope = require("telescope")
      local pickersOpts = {
        respect_gitignore = true,
        search_dirs = { "./", ".github/" },
      }

      telescope.setup({
        defaults = {
          prompt_prefix = "🔎 ",
          file_ignore_patterns = {
            ".git",
            "node_modules",
          },
        },
        pickers = {
          live_grep = pickersOpts,
          find_files = pickersOpts,
        },
      })

      -- extensions
      telescope.load_extension("noice")
      telescope.load_extension("notify")
    end,
  },
}
