-- Lightweight yet powerful formatter plugin for Neovim

return {
  'stevearc/conform.nvim',

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

    formatter_by_ft = {
      astro = { "prettierd" },
      bash = { "beautysh" },
      css = { "prettierd" },
      html = { "lsp" },
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      json = { "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      python = {
        "ruff",
        -- remove_trailing_whitespace,
        -- shell({ cmd = { "ruff", "format", "--stdin-filename", "%", "-" } }),
      },
      scss = { "prettierd" },
      sh = { "beautysh" },
      svelte = {
        -- if_file_exists({
        --   pattern = ".eslintrc.*",
        --   formatter = eslint_d_fix,
        -- }),
        -- if_file_exists({
        --   pattern = { ".prettierrc", ".prettierrc.*", "prettier.config.*" },
        --   formatter = prettierd,
        -- }),
        "lsp",
      },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      yaml = { "prettierd" },
      zsh = { "beautysh" },
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
