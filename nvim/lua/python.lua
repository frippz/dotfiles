local host = string.gsub(vim.fn.system("which python"), "\n", "")

if string.match(host, "not found") then
  host = string.gsub(vim.fn.system("which python3"), "\n", "")
end

vim.g.python3_host_prog = host
