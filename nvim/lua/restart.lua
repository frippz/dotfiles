-- Restart the current session without saving it by using a temporary session
local tmp_session = vim.fn.stdpath("state") .. "/Restart.vim"
local esc_tmp_session = vim.fn.fnameescape(tmp_session)

function _G.after_restart(orig_session)
  vim.cmd("source " .. esc_tmp_session)
  vim.v.this_session = orig_session
end

local session_restart = function()
  local restart_cmd = [[
    mksession! %s | confirm restart lua _G.after_restart(%s)
  ]]
  vim.cmd("silent! write")
  vim.cmd(restart_cmd:format(esc_tmp_session, ("%q"):format(vim.v.this_session)))
end

vim.keymap.set("n", "<Leader>R", session_restart, { desc = "Restart" })
