-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--  Live substitution
vim.opt.inccommand = "nosplit"

-- Search
vim.opt.hlsearch = true -- highlight all results
vim.opt.incsearch = true -- but do highlight as you type your search.
vim.opt.ignorecase = true -- make searches case-insensitive...
vim.opt.smartcase = true -- ... unless they contain at least one capital letter
vim.opt.gdefault = true -- have :s///g flag by default on"

-- Visual Stuff
vim.opt.number = true -- show line numbers
vim.opt.cursorline = true -- highlight the current line
vim.opt.history = 200 -- remember a lot of stuff
vim.opt.ruler = true -- Always show info along bottom.
vim.opt.wrap = true -- Wrap lines
vim.opt.linebreak = true -- Don't break words
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.signcolumn = "yes"
vim.opt.shortmess = "c"
vim.opt.shortmess:append("F")

-- Specify listchars (invisibles) with literal unicode in a :set command
vim.scriptencoding = "utf-8"
vim.opt.list = false
vim.opt.listchars = {
  tab = "▸ ",
  eol = "¬",
  trail = "·",
  space = "·",
}

-- Highlight yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    -- Only highlight when the yank is done via visual mode or a normal mode command
    if vim.v.event.operator == "y" and vim.v.event.regtype ~= "" then
      -- Temporarily highlight the yanked region
      vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
    end
  end,
  group = highlight_group,
})

-- auto-reload files changed on disk
vim.opt.autoread = true

-- check for changes after inactivity
-- nvimAutoCmd("CursorHold",  { pattern = "*", command = "checktime" })
-- nvimAutoCmd("FocusGained", { pattern = "*", command = "checktime" })
vim.api.nvim_create_autocmd({ "CursorHold", "FocusGained" }, {
  pattern = "*",
  callback = function()
    vim.cmd.checktime()
  end,
})

-- disable swap files
vim.opt.updatecount = 0
vim.opt.backup = false
vim.opt.swapfile = false

-- Indentation
vim.opt.autoindent = true -- auto-indent
vim.opt.tabstop = 2 -- tab spacing
vim.opt.softtabstop = 2 -- unify
vim.opt.shiftwidth = 2 -- indent/outdent by 2 columns
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smarttab = true -- use tabs at the start of a line, spaces elsewhere
vim.opt.backspace = { "indent", "eol", "start" } -- Backspace through anything in insert mode

-- Enable mouse
vim.opt.mouse = "a"

-- Disable delays for <Leader>
vim.opt.timeoutlen = 1000
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 0

-- Use relative line numbers
vim.opt.relativenumber = true

-- " Default netrw list style
vim.g.netrw_liststyle = 3

-- Disable netrw history
vim.g.netrw_dirhistmax = 0

-- Session options
vim.opt.sessionoptions:remove({ "options", "blank", "winsize", "localoptions" }) -- do not store options, empty windows, window sizes, or local options
vim.opt.sessionoptions:append("globals") -- store globals for plugin state (e.g. Snacks)

-- Make copy operations work with the clipboard
vim.opt.clipboard = "unnamed"

-- Nice and simple folding:
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldcolumn = "1"
vim.opt.fillchars:append({ fold = " " })
