-- Find, Filter, Preview, Pick.

return {
  "nvim-telescope/telescope.nvim",

  -- disable plugin
  enabled = false,

  branch = "0.1.x",
  lazy = false,

  keys = {
    {
      "<leader>ft",
      ":Telescope<CR>",
      desc = "Run Telescope",
    },
    {
      "<C-p>",
      ":Telescope find_files hidden=true<CR>",
      desc = "Telescope find files",
    },
    {
      "<C-b>",
      ":Telescope buffers<CR>",
      desc = "Telescope show open buffers",
    },
    {
      "<leader>fg",
      ":Telescope live_grep<CR>",
      desc = "Telescope project search",
    },
    {
      "<leader>fh",
      ":Telescope help_tags<CR>",
      desc = "Telescope show help",
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
          "__bundled",
          "__published",
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--no-ignore",
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
    telescope.load_extension("todo-comments")
    telescope.load_extension("project")
  end,
}
