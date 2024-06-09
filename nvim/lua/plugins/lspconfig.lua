return {
  "neovim/nvim-lspconfig",
  version = "v0.1.7",
  config = function()
    -- nvim-cmp capabilities
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    -- local coq = require("coq")

    -- typescript
    lspconfig.tsserver.setup({
      capabilities = capabilities,
    })

    -- eslint
    lspconfig.eslint.setup({
      capabilities = capabilities,
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
    -- lspconfig.svelte.setup(coq.lsp_ensure_capabilities({}))

    -- swift
    lspconfig.sourcekit.setup({
      capabilities = capabilities,
    })

    -- python
    lspconfig.pyright.setup({
      capabilities = capabilities,
    })

    -- html
    lspconfig.html.setup({
      capabilities = capabilities,
    })

    -- yaml
    lspconfig.yamlls.setup({
      capabilities = capabilities,
    })
  end,
}
