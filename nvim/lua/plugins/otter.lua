-- LSP support for languages embedded in other filetypes.

return {
  "jmbuhr/otter.nvim",

  ft = { "svelte" },

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    extensions = {
      scss = "scss",
    },
  },

  config = function(_, opts)
    local otter = require("otter")
    otter.setup(opts)

    local function activate_scss(bufnr)
      if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype ~= "svelte" then
        return
      end

      vim.api.nvim_buf_call(bufnr, function()
        -- Svelte's Tree-sitter query exposes <style lang="scss"> as SCSS.
        -- Keep completion and diagnostics with the Svelte LSP; Otter is used
        -- here for navigation through the dedicated Sass language server.
        otter.activate({ "scss" }, false, false)
      end)
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("otter-svelte-scss", { clear = true }),
      pattern = "svelte",
      callback = function(event)
        activate_scss(event.buf)
      end,
    })

    -- The first Svelte FileType event loads this plugin before the autocmd
    -- above exists, so activate Otter explicitly for the current buffer.
    activate_scss(vim.api.nvim_get_current_buf())
  end,
}
