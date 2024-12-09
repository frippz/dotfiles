-- disable inline diagnostics
vim.diagnostic.config({
  virtual_text = false, -- Disable inline error messages
  signs = true, -- Retain signs in the gutter
  underline = true, -- Keep underline styling for errors
  update_in_insert = false,
  severity_sort = true,
})
