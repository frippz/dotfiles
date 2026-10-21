return {
  "pmizio/typescript-tools.nvim",

  enabled = true,

  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },

  ft = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
  },

  opts = {
    -- Leave Deno projects to denols
    root_dir = function(bufnr, on_dir)
      if vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then
        return
      end
      on_dir(require("typescript-tools.utils").get_root_dir(bufnr))
    end,

    settings = {
      code_lens = "all",
    },
  },
}
