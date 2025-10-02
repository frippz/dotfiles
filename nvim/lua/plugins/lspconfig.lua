-- Quickstart configs for Nvim LSP

return {
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },

  keys = {
    { "gR", "<cmd>Telescope lsp_references<CR>", desc = "Show LSP references" },
    { "gr", vim.lsp.buf.references, desc = "Show references (vim.lsp.buf)" },
    { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
    { "gd", vim.lsp.buf.definition, desc = "Show LSP definitions" },
    { "gi", "<cmd>Telescope lsp_implementations<CR>", desc = "Show LSP implementations" },
    { "gI", vim.lsp.buf.implementation, desc = "Go to implementation" },
    { "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", desc = "Show LSP type definitions" },
    { "<leader>ca", vim.lsp.buf.code_action, { "n", "v" }, desc = "See available code actions" },
    { "<leader>rn", vim.lsp.buf.rename, desc = "Smart rename" },
    { "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "Show buffer diagnostics" },
    { "<leader>d", vim.diagnostic.open_float, desc = "Show line diagnostics" },
    -- { "<leader>dp", vim.diagnostic.jump({ count = -1, float = true }), desc = "Go to previous diagnostic" },
    -- { "<leader>dn", vim.diagnostic.jump({ count = 1, float = true }), desc = "Go to next diagnostic" },
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
      -- put other shared defaults here, e.g. on_attach if you have one
    })

    -- server configs
    vim.lsp.config("astro", {})

    vim.lsp.config("denols", {
      root_markers = { "deno.json", "deno.jsonc", "deno.lock" },
    })

    vim.lsp.config("eslint", {
      root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
      cmd = { "EslintFixAll" },
    })

    vim.lsp.config("bashls", {})

    vim.lsp.config("cssls", {})

    vim.lsp.config("css_variables", {})

    vim.lsp.config("stylelint_lsp", {
      filetypes = { "css", "scss" },
      settings = {
        stylelintplus = {
          autoFixOnSave = true,
          autoFixOnFormat = true,
        },
      },
    })

    vim.lsp.config("svelte", {
      init_options = {
        configuration = {
          svelte = {
            plugin = {
              svelte = {
                completions = {
                  enable = true,
                  insertSnippets = false, -- this disables snippets
                },
              },
            },
          },
        },
      },
    })

    vim.lsp.config("ts_ls", {
      filetypes = {
        "typescript",
        "javascript",
        -- "svelte",
      },
      single_file_support = false,
      root_markers = { "package.json" },
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
      "svelte",
      "ts_ls",
      "yamlls",
    })
  end,
}
