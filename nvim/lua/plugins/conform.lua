-- Lightweight yet powerful formatter plugin for Neovim

return {
  "stevearc/conform.nvim",

  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>F",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },

  ---@module "conform"
  ---@type conform.setupOpts
  opts = {

    formatters_by_ft = {
      astro = { "prettierd" },
      bash = { "shfmt" },
      css = { "prettierd" },
      html = { "lsp" },
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      json = { "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      python = { "ruff" },
      scss = { "prettierd" },
      sh = { "beautysh" },
      svelte = { "lsp" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      yaml = { "prettierd" },
      zsh = { "beautysh" },

      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ["_"] = { "trim_whitespace" },
    },

    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },

    -- Set up format-on-save
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500,
    },

    -- Customize formatters
    formatters = {
      shfmt = {
        append_args = { "-i", "2" },
      },
    },
  },
}
