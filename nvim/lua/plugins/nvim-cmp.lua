-- A completion plugin for Neovim

return {
  "hrsh7th/nvim-cmp",

  enabled = false,

  event = "InsertEnter",

  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "brenoprata10/nvim-highlight-colors",
    {
      "jdrupal-dev/css-vars.nvim",
      opts = {
        cmp_filetypes = { "css", "svelte" },
        search_extensions = { "css" },
      },
    },
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      preselect = cmp.PreselectMode.None, -- prevent selection in the middle of the dropdown

      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text in the current buffer
        { name = "path" }, -- file system paths
        { name = "css_vars" },
      }),

      formatting = {
        format = require("nvim-highlight-colors").format,
      },
    })
  end,
}
