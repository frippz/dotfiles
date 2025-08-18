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
    local lspconfig = require("lspconfig")

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- custom diagnostic symbols in the gutter
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- typescript
    -- lspconfig.ts_ls.setup({
    --   capabilities = capabilities,
    --   root_dir = lspconfig.util.root_pattern("package.json"),
    --   single_file_support = false,
    -- })

    -- astro
    lspconfig.astro.setup({
      capabilities = capabilities,
    })

    -- deno
    lspconfig.denols.setup({
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    })

    -- eslint
    lspconfig.eslint.setup({
      capabilities = capabilities,
      ---@diagnostic disable-next-line unused-local
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    })

    -- bash
    lspconfig.bashls.setup({
      capabilities = capabilities,
    })

    -- cssls
    lspconfig.cssls.setup({
      capabilities = capabilities,
    })

    -- css variables completion
    lspconfig.css_variables.setup({
      capabilities = capabilities,
    })

    -- stylelint
    lspconfig.stylelint_lsp.setup({
      filetypes = { "css", "scss" },
      settings = {
        stylelintplus = {
          autoFixOnSave = true,
          autoFixOnFormat = true,
        },
      },
      capabilities = capabilities,
    })

    -- svelte
    lspconfig.svelte.setup({
      capabilities = capabilities,
    })

    -- python
    lspconfig.ruff.setup({
      capabilities = capabilities,
    })

    -- html
    lspconfig.html.setup({
      capabilities = capabilities,
    })

    -- lua
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
    })

    -- yaml
    lspconfig.yamlls.setup({
      capabilities = capabilities,
    })
  end,
}
