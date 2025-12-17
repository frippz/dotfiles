-- Quickstart configs for Nvim LSP

return {
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },

  keys = {
    { "gr", vim.lsp.buf.references, desc = "Show references (vim.lsp.buf)" },
    { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
    { "gd", vim.lsp.buf.definition, desc = "Show LSP definitions" },
    { "gI", vim.lsp.buf.implementation, desc = "Go to implementation" },
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
    { "K", vim.lsp.buf.hover, desc = "Show documentation for what is under cursor" },
    { "<leader>rs", ":LspRestart<CR>", desc = "Restart LSP" },
  },

  config = function()
    -- capabilities from your completion plugin
    local capabilities = require("blink.cmp").get_lsp_capabilities({
      textDocument = { completion = { completionItem = { snippetSupport = false } } },
    })

    -- gutter signs
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- global defaults (applies to all servers unless overridden)
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- server configs
    vim.lsp.config("astro", {})

    vim.lsp.config("denols", {
      root_dir = function(fname)
        local util = require("lspconfig.util")
        return util.root_pattern("deno.json", "deno.jsonc", "deno.lock")(fname)
      end,
    })

    vim.lsp.config("eslint", {
      root_dir = function(fname)
        local util = require("lspconfig.util")
        return util.root_pattern(
          "eslint.config.mjs",
          "eslint.config.js",
          ".eslintrc.js",
          ".eslintrc.json",
          "tsconfig.json",
          "package.json",
          "jsconfig.json",
          ".git"
        )(fname)
      end,
      cmd = { "EslintFixAll" },
    })

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

    -- vim.lsp.config("ts_ls", {
    --   filetypes = {
    --     "typescript",
    --     "javascript",
    --   },
    --   single_file_support = false,
    --   root_markers = { "package.json" },
    -- })

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
      "svelte",
      "ts_ls",
      "yamlls",
    })
  end,
}
