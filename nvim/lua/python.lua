-- Get the path of the Python interpreter by running the 'which python' command
-- and removing the newline character from the result.
local host = string.gsub(vim.fn.system("which python"), "\n", "")

-- If result doesn’t contain path (i.e., 'which python' returned "not found"),
-- try getting the path of Python 3 interpreter instead.
if string.match(host, "not found") then
  host = string.gsub(vim.fn.system("which python3"), "\n", "")
end

-- Set global variable 'python3_host_prog' in Neovim
-- to the path of the Python interpreter.
vim.g.python3_host_prog = host
