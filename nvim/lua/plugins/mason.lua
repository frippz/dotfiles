return {
  "williamboman/mason.nvim",
  lazy = false,
  version = "v1.10.0",
  config = function()
    require("mason").setup()
  end,
  {
    "whoissethdaniel/mason-tool-installer.nvim",
    dependencies = "mason.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "bash-language-server",
          "beautysh",
          "black",
          "css-lsp",
          "eslint-lsp",
          "html-lsp",
          "lua-language-server",
          "markdownlint",
          "prettierd",
          "shfmt",
          "stylelint-lsp",
          "stylua",
          "svelte-language-server",
          "typescript-language-server",
          "yaml-language-server",
        },

        start_delay = 3000, -- 3 second delay
        auto_update = true, -- check each tool for updates
        run_on_start = true, -- automatically install / update on startup
        debounce_hours = 8, -- at least 8 hours between attempts to install/update
      })
    end,
  },
}
