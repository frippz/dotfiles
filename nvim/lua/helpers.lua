-- Helpers
---@diagnostic disable: lowercase-global

-- map function
local mapOpts = { noremap = true, silent = true }

---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? vim.keymap.set.Opts
function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", mapOpts, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end
