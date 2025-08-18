-- Helpers
---@diagnostic disable: lowercase-global
o = vim.opt
g = vim.g
nvimCmd = vim.api.nvim_command
nvimAutoCmd = vim.api.nvim_create_autocmd

-- map function
local mapOpts = { noremap = true, silent = true }

function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", mapOpts, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end
