-- disable inline diagnostics
vim.diagnostic.config({
  virtual_text = false, -- Disable inline error messages
  signs = { -- Retain signs in the gutter
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true, -- Keep underline styling for errors
  update_in_insert = false,
  severity_sort = true,
})
