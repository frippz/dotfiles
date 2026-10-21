-- Lightweight yet powerful formatter plugin for Neovim

local js_formatters = {
  "biome",
  "biome-check",
  "biome-organize-imports",
  "prettierd",
  "eslint_d",
}

-- Only run biome formatters in projects that have a biome config
local function has_biome_config(_, ctx)
  return vim.fs.find({
    "biome.json",
    "biome.jsonc",
  }, { path = ctx.filename, upward = true })[1] ~= nil
end

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
      astro = { "biome", "prettierd" },
      bash = { "shfmt" },
      css = { "biome", "prettierd" },
      html = { "lsp" },
      javascript = js_formatters,
      javascriptreact = js_formatters,
      json = { "jsonlint", "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      python = {
        "ruff_fix",
        "ruff_format",
        stop_after_first = false,
      },
      scss = { "prettierd" },
      sh = { "shfmt" },
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
      stop_after_first = true,
    },

    -- Set up format-on-save
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 2000,
    },

    -- Customize formatters
    formatters = {
      biome = {
        condition = has_biome_config,
      },
      ["biome-check"] = {
        condition = has_biome_config,
      },
      ["biome-organize-imports"] = {
        condition = has_biome_config,
      },
      eslint_d = {
        condition = function(_, ctx)
          return vim.fs.find(function(name)
            return name:match("^eslint%.config%.[cm]?[jt]s$") or name:match("^%.eslintrc")
          end, { path = ctx.filename, upward = true })[1] ~= nil
        end,
      },
      prettierd = {
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
      shfmt = {
        append_args = { "-i", "2", "-ci" },
      },
    },
  },
}
