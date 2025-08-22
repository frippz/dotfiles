return {
  "folke/snacks.nvim",

  priority = 1000,
  lazy = false,

  ---@module 'snacks'
  ---@type snacks.Config
  opts = {

    -- Bigfile
    bigfile = { enabled = true },

    -- Dashboard
    dashboard = { enabled = true },

    -- Explorer
    explorer = { enabled = true },

    -- Indent
    indent = { enabled = true },

    -- Input
    input = { enabled = true },

    -- File picker
    picker = {
      enabled = true,

      sources = {
        explorer = {
          actions = {

            -- Custom action to copy file path in file picker
            copy_file_path = {
              action = function(_, item)
                if not item then
                  return
                end

                local vals = {
                  ["BASENAME"] = vim.fn.fnamemodify(item.file, ":t:r"),
                  ["EXTENSION"] = vim.fn.fnamemodify(item.file, ":t:e"),
                  ["FILENAME"] = vim.fn.fnamemodify(item.file, ":t"),
                  ["PATH"] = item.file,
                  ["PATH (CWD)"] = vim.fn.fnamemodify(item.file, ":."),
                  ["PATH (HOME)"] = vim.fn.fnamemodify(item.file, ":~"),
                  ["URI"] = vim.uri_from_fname(item.file),
                }

                local options = vim.tbl_filter(function(val)
                  return vals[val] ~= ""
                end, vim.tbl_keys(vals))
                if vim.tbl_isempty(options) then
                  vim.notify("No values to copy", vim.log.levels.WARN)
                  return
                end
                table.sort(options)
                vim.ui.select(options, {
                  prompt = "Choose to copy to clipboard:",
                  format_item = function(list_item)
                    return ("%s: %s"):format(list_item, vals[list_item])
                  end,
                }, function(choice)
                  local result = vals[choice]
                  if result then
                    vim.fn.setreg("+", result)
                    Snacks.notify.info("Yanked `" .. result .. "`")
                  end
                end)
              end,
            },
          },
          win = {
            list = {
              keys = {
                ["y"] = "copy_file_path",
              },
            },
          },
        },
      },
    },

    -- Notifier
    notifier = { enabled = true },

    -- Quickfile
    quickfile = { enabled = true },

    -- Scope
    scope = { enabled = true },

    -- Scroll
    scroll = { enabled = true },

    -- Statuscolumn
    statuscolumn = { enabled = true },

    -- Words
    words = { enabled = true },
  },

  keys = {
    {
      "<C-p>",
      ":lua Snacks.picker.files()<cr>",
      desc = "Toggle file picker",
    },
    {
      "<C-f>",
      ":lua Snacks.picker.explorer()<cr>",
      desc = "Toggle file explorer",
    },
    {
      "<C-b>",
      ":lua Snacks.picker.buffers()<cr>",
      desc = "Toggle buffers explorer",
    },
    {
      "<leader>fg",
      ":lua Snacks.picker.grep()<cr>",
      desc = "Toggle search",
    },
  },
}
