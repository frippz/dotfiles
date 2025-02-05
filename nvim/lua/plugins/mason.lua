-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.

return {
  "williamboman/mason.nvim",

  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✔",
          package_pending = "→",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "cssls",
        "css_variables",
        "eslint",
        "emmet_ls",
        "graphql",
        "html",
        "lua_ls",
        "pyright",
        "svelte",
        "ts_ls",
        "yamlls",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "black",
        "eslint",
        "isort",
        "prettierd",
        "pylint",
        "shfmt",
        "stylua",
      },
    })
  end,
}
