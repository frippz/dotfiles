return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },

  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        map("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        map("n", "gr", ":lua vim.lsp.buf.references()<CR>", mapOpts)

        opts.desc = "Go to declaration"
        map("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        map("n", "gd", ":lua vim.lsp.buf.definition()<CR>", mapOpts)

        opts.desc = "Show LSP implementations"
        map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        map("n", "gI", ":lua vim.lsp.buf.implementation()<CR>", mapOpts)

        opts.desc = "Show LSP type definitions"
        map("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        map("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        map("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        map("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        map("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        map("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- custom diagnostic symbols in the gutter
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- typescript
    lspconfig.tsserver.setup({
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("package.json"),
      single_file_support = false,
    })

    -- deno
    lspconfig.denols.setup({
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    })

    -- eslint
    lspconfig.eslint.setup({
      filetypes = { "js", "ts" },
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

    -- lua
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          -- make the lsp recognize "vim" global
          diagnostics = {
            disable = { "lowercase-global" },
            globals = { "vim" },
          },
          workspace = {
            -- make the lsp aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- yaml
    lspconfig.yamlls.setup({
      capabilities = capabilities,
    })
  end,
}
