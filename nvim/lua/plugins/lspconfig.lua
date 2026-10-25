-- Quickstart configs for Nvim LSP

return {
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "saghen/blink.cmp",
  },

  keys = {
    { "<leader>ca", vim.lsp.buf.code_action, { "n", "v" }, desc = "See available code actions" },
    { "<leader>rn", vim.lsp.buf.rename, desc = "Smart rename" },
    { "<leader>d", vim.diagnostic.open_float, desc = "Show line diagnostics" },
    {
      "dp",
      function()
        vim.diagnostic.jump({ count = -1, float = true })
      end,
      desc = "Go to previous diagnostic",
    },
    {
      "dn",
      function()
        vim.diagnostic.jump({ count = 1, float = true })
      end,
      desc = "Go to next diagnostic",
    },
    { "<leader>rs", ":lsp restart<CR>", desc = "Restart LSP" },
  },

  config = function()
    -- capabilities from your completion plugin
    local capabilities = require("blink.cmp").get_lsp_capabilities({
      textDocument = { completion = { completionItem = { snippetSupport = false } } },
    })

    -- global defaults (applies to all servers unless overridden)
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- server configs
    vim.lsp.config("astro", {})

    vim.lsp.config("emmet_language_server", {
      filetypes = { "html", "astro", "typescriptreact", "javascriptreact", "svelte" },
    })

    vim.lsp.config("bashls", {})

    local cssCapabilities = vim.lsp.protocol.make_client_capabilities()
    cssCapabilities.textDocument.completion.completionItem.snippetSupport = true

    vim.lsp.config("cssls", {
      capabilities = cssCapabilities,
    })

    -- vim.lsp.config("css_variables", {})

    vim.lsp.config("stylelint_lsp", {
      filetypes = { "css", "scss" },
      settings = {
        stylelintplus = {
          autoFixOnSave = true,
          autoFixOnFormat = true,
        },
      },
    })

    vim.lsp.config("svelte", {})

    vim.lsp.config("tailwindcss", {})

    vim.lsp.config("somesass_ls", {})

    -- Default root_dir already leaves Deno projects to denols
    vim.lsp.config("vtsls", {
      settings = {
        typescript = {
          referencesCodeLens = { enabled = true },
          implementationsCodeLens = { enabled = true },
        },
        javascript = {
          referencesCodeLens = { enabled = true },
        },
      },
      on_attach = function(_, bufnr)
        vim.lsp.codelens.enable(true, { bufnr = bufnr })
      end,
    })

    vim.lsp.config("ruff", {})

    vim.lsp.config("html", {})

    vim.lsp.config("lua_ls", {})

    vim.lsp.config("yamlls", {})

    vim.lsp.enable({
      "astro",
      "bashls",
      "css_variables",
      "cssls",
      "denols",
      "eslint",
      "html",
      "lua_ls",
      "ruff",
      "stylelint_lsp",
      "somesass_ls",
      "svelte",
      "tailwindcss",
      "yamlls",
    })
  end,
}
