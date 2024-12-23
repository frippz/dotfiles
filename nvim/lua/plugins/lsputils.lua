-- Better defaults for nvim-lsp actions

return {
  "rishabhrd/nvim-lsputils",

  dependencies = {
    "rishabhrd/popfix",
  },

  config = function()
    -- Use custom handler for code actions (e.g., refactoring suggestions).
    vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler

    -- Enhance UI for showing all references to a symbol.
    vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler

    -- Improve navigation to a symbol's definition.
    vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler

    -- Enhance navigation to a symbol's declaration.
    vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler

    -- Improve display of type definitions for symbols.
    vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler

    -- Enhance UI for finding implementations of a symbol.
    vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler

    -- Better display of document symbols (e.g., functions, variables).
    vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler

    -- Improve display of workspace-wide symbols.
    vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler
  end,
}
