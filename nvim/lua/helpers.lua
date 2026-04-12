-- Helpers
---@diagnostic disable: lowercase-global

-- map function
local mapOpts = { noremap = true, silent = true }

function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", mapOpts, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end
