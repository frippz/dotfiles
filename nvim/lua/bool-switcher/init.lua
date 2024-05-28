local M = {}

-- switch booleans
function M.switch_boolean()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  local boolean_patterns = {
    ["true"] = "false",
    ["false"] = "true",
    ["True"] = "False",
    ["False"] = "True",
    ["TRUE"] = "FALSE",
    ["FALSE"] = "TRUE",
  }

  for pattern, replacement in pairs(boolean_patterns) do
    if line:find(pattern) then
      local new_line = line:gsub(pattern, replacement)
      vim.api.nvim_set_current_line(new_line)
      vim.api.nvim_win_set_cursor(0, { row, col })
      return
    end
  end

  vim.api.nvim_out_write("No boolean found on the current line\n")
end

-- setup key mapping
function M.setup(key)
  vim.api.nvim_set_keymap(
    "n",
    key,
    ':lua require("bool-switcher").switch_boolean()<CR>',
    { noremap = true, silent = true }
  )
end

return M
