-- Lightweight yet powerful formatter plugin for Neovim

local js_formatters = {
  "biome",
  "biome-check",
  "prettierd",
  "eslint_d",
}

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
      javascript = js_formatters,
      javascriptreact = js_formatters,
      json = { "jsonlint", "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      python = { "ruff" },
      scss = { "prettierd" },
      sh = { "beautysh" },
      svelte = { "lsp" },
      typescript = js_formatters,
      typescriptreact = js_formatters,
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
