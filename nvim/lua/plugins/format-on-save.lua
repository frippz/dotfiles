return {
  "elentok/format-on-save.nvim",

  config = function()
    local format_on_save = require("format-on-save")
    local formatters = require("format-on-save.formatters")

    format_on_save.setup({
      exclude_path_patterns = {
        "/node_modules/",
        ".local/share/nvim/lazy",
      },
      formatter_by_ft = {
        css = formatters.prettierd,
        html = formatters.lsp,
        javascript = formatters.prettierd,
        javascriptreact = formatters.prettierd,
        json = formatters.prettierd,
        lua = formatters.stylua,
        markdown = formatters.prettierd,
        python = formatters.black,
        scss = formatters.prettierd,
        sh = formatters.shfmt,
        svelte = formatters.prettierd,
        typescript = formatters.prettierd,
        typescriptreact = formatters.prettierd,
        yaml = formatters.prettierd,
        zsh = formatters.beautysh,
      },

      -- fallback formatter to use when no formatters match the current filetype
      fallback_formatter = {
        formatters.remove_trailing_whitespace,
        formatters.remove_trailing_newlines,
      },
    })
  end,
}