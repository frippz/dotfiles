-- Lightweight yet powerful formatter plugin for Neovim

return {
  "stevearc/conform.nvim",

  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  keys = {
    {
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
      javascript = { "prettierd", "eslint_d" },
      javascriptreact = { "prettierd", "eslint_d" },
      json = { "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      python = { "ruff" },
      scss = { "prettierd" },
      sh = { "beautysh" },
      svelte = { "lsp" },
      typescript = { "prettierd", "eslint_d" },
      typescriptreact = { "prettierd", "eslint_d" },
      yaml = { "prettierd" },
      zsh = { "shfmt" },

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
      timeout_ms = 2000,
    },

    -- Customize formatters
    formatters = {
      prettier = {
        condition = function(_, ctx)
          return vim.fs.find({
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.mjs",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
          }, { path = ctx.filename, upward = true })[1] ~= nil
        end,
      },
      ruff = {
        command = "ruff",
        args = { "format", "--stdin-filename", "%", "-" },
      },
      shfmt = {
        append_args = { "-i", "2" },
      },
    },
  },
}
