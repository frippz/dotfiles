-- Performant, batteries-included completion plugin for Neovim

return {
  "saghen/blink.cmp",

  dependencies = {
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
  },

  version = "*",

  opts = {
    completion = {

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        window = { border = "rounded" },
      },

      menu = {
        border = "rounded",

        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
            return { pos[1] - 1, pos[2] }
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,

        draw = {
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "kind" },
          },

          components = {
            kind_icon = {
              text = function(item)
                local kind = require("lspkind").symbol_map[item.kind] or ""
                return kind .. " "
              end,
              highlight = "CmpItemKind",
            },

            label = {
              text = function(item)
                return item.label
              end,
              highlight = "CmpItemAbbr",
            },

            kind = {
              text = function(item)
                return item.kind
              end,
              highlight = "CmpItemKind",
            },
          },
        },
      },
    },

    -- super-TAB configuration
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = {
        function(cmp)
          return cmp.select_next()
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          return cmp.select_prev()
        end,
        "snippet_backward",
        "fallback",
      },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-up>"] = { "scroll_documentation_up", "fallback" },
      ["<C-down>"] = { "scroll_documentation_down", "fallback" },
    },

    -- Experimental signature help support
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },

    -- Disable completions in command line
    cmdline = {
      enabled = false,
    },

    -- Disable completions in terminal
    term = {
      enabled = false,
    },

    --[[
    sources = {
      providers = {
        lsp = {
          min_keyword_length = 1, -- Number of characters to trigger provider
          score_offset = 3, -- Boost/penalize the score of the items
        },
        path = {
          min_keyword_length = 2,
          score_offset = 1, -- Boost/penalize the score of the items
        },
        snippets = {
          min_keyword_length = 3,
          score_offset = 0, -- Boost/penalize the score of the items
        },
        buffer = {
          min_keyword_length = 2,
          max_items = 5,
          score_offset = 2, -- Boost/penalize the score of the items
        },
      },
    },
    ]]
  },
}
