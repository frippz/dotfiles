return {
  "folke/snacks.nvim",

  priority = 1000,
  lazy = false,

  dependencies = { "nvim-mini/mini.icons" },

  ---@module 'snacks'
  ---@type snacks.Config
  opts = {

    -- Bigfile
    bigfile = {
      enabled = true,
    },

    -- Bufdelete - Delete buffers without disrupting window layout
    bufdelete = {
      enabled = true,
    },

    -- Dashboard
    dashboard = {
      enabled = true,

      sections = {
        {
          section = "header",
        },

        -- Quick Actions
        {
          gap = 1,
          padding = 2,
          {
            icon = " ",
            key = "f",
            desc = "Find File",
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            icon = " ",
            key = "e",
            desc = "Explorer",
            action = ":lua Snacks.picker.explorer()",
          },
          {
            icon = " ",
            key = "g",
            desc = "Find Text",
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = " ",
            key = "s",
            desc = "Restore Session",
            section = "session",
          },
          {
            icon = " ",
            key = "O",
            desc = "Overseer",
            action = ":lua require('overseer').run_template()",
          },
          {
            icon = "󰒲 ",
            key = "L",
            desc = "Lazy",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil,
          },
          {
            icon = " ",
            key = "M",
            desc = "Mason",
            action = ":Mason",
          },
          {
            icon = " ",
            key = "q",
            desc = "Quit",
            action = ":qa",
          },
        },

        -- Startup stats
        {
          section = "startup",
          padding = 1,
        },

        -- Neovim version
        {
          text = "v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
          align = "center",
          padding = 1,
        },
      },
    },

    -- Explorer
    explorer = {
      enabled = true,
    },

    -- GitHub CLI
    gh = {
      enabled = true,
    },

    -- Indent
    indent = {
      enabled = true,
    },

    -- Input
    input = {
      enabled = true,
    },

    -- File picker
    picker = {
      enabled = true,

      sources = {
        explorer = {

          include = {
            ".*ignore",
            ".env*",
            ".github",
            ".node-version",
            ".nvmrc",
            ".npmrc",
            ".prettierrc",
            ".ruby-version",
            ".stylelintrc",
            ".moon",
            ".husky",
          },

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
    notifier = {
      enabled = false,

      ---@type snacks.notifier.style
      style = "fancy",
      top_down = false,
    },

    -- Quickfile
    quickfile = { enabled = true },

    -- Scope
    scope = { enabled = true },

    -- Scratch
    scratch = { enabled = false },

    -- Scroll
    scroll = { enabled = true },

    -- Statuscolumn
    statuscolumn = { enabled = true },

    -- Words
    words = { enabled = true },

    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
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
    {
      "<Leader>bc",
      ":lua Snacks.bufdelete()<cr>",
      desc = "Close current buffer",
    },
    {
      "<Leader>bk",
      ":lua Snacks.bufdelete.other()<cr>",
      desc = "Close others buffers",
    },
    {
      "<leader>n",
      ":lua Snacks.notifier.show_history()<cr>",
      desc = "Notification History",
    },

    -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions({ tagstack = true, reuse_win = true })
      end,
      desc = "LSP Definition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "LSP Declaration",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      desc = "LSP References",
    },
    {
      "gi",
      function()
        Snacks.picker.lsp_implementations({ tagstack = true, reuse_win = true })
      end,
      desc = "LSP Implementations",
    },
    {
      "<leader>gt",
      function()
        Snacks.picker.lsp_type_definitions({ tagstack = true, reuse_win = true })
      end,
      desc = "LSP Type Definition",
    },
    {
      "<leader>D",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Buffer diagnostics",
    },

    -- GitHub
    {
      "<leader>gi",
      function()
        Snacks.picker.gh_issue()
      end,
      desc = "GitHub Issues (open)",
    },
    {
      "<leader>gI",
      function()
        Snacks.picker.gh_issue({ state = "all" })
      end,
      desc = "GitHub Issues (all)",
    },
    {
      "<leader>gp",
      function()
        Snacks.picker.gh_pr()
      end,
      desc = "GitHub Pull Requests (open)",
    },
    {
      "<leader>gP",
      function()
        Snacks.picker.gh_pr({ state = "all" })
      end,
      desc = "GitHub Pull Requests (all)",
    },
  },
}
