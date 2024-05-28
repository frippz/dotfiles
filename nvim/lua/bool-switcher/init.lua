local M = {}

-- switch booleans
function M.switch_boolean()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  local boolean_patterns = {
    ["true"] = "false",
    ["false"] = "true",
  }

  -- convert to lower case for case insensitive matching
  local lower_line = line:lower()

  for pattern, replacement in pairs(boolean_patterns) do
    -- find the pattern in the lower case line
    local start_pos, end_pos = lower_line:find(pattern)
    if start_pos then
      -- extract the original case-sensitive substring
      local original_boolean = line:sub(start_pos, end_pos)
      -- determine the case of the original boolean and match it in the replacement
      if original_boolean:upper() == original_boolean then
        replacement = replacement:upper()
      elseif original_boolean:sub(1, 1):upper() == original_boolean:sub(1, 1) then
        replacement = replacement:gsub("^%l", string.upper)
      end
      -- replace the original boolean with the new one
      local new_line = line:sub(1, start_pos - 1) .. replacement .. line:sub(end_pos + 1)
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
