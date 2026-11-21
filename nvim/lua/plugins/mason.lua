-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.

return {
  "mason-org/mason.nvim",

  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✔",
          package_pending = "→",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- Every server listed here is installed and enabled automatically; per-server
      -- settings live in lspconfig.lua.
      ensure_installed = {
        "astro",
        "bashls",
        "cssls",
        "css_variables",
        "denols",
        "emmet_language_server",
        "eslint",
        "graphql",
        "html",
        "lua_ls",
        "ruff",
        "somesass_ls",
        "stylelint_lsp",
        "svelte",
        "tailwindcss",
        "vtsls",
        "yamlls",
      },
      -- biome and stylua are installed below for conform; their LSPs would duplicate it.
      automatic_enable = {
        exclude = { "biome", "stylua" },
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "biome",
        "jsonlint",
        "eslint",
        "eslint_d",
        "prettierd",
        "shfmt",
        "stylua",
      },
    })
  end,
}
