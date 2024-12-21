-- Map leader to spacebar
g.mapleader = " "

-- Remap save
map("n", "<Leader>w", ":w<CR>")

-- Save with no autocmd
map("n", "<Leader>n", ":noa w<CR>")

-- Quickly reload init.lua
map("n", "<Leader>sv", ":luafile ~/.config/nvim/init.lua<CR>")

-- Remap exit terminal mode
map("t", "<Esc>", "<C-\\><C-n>")

-- Escape insert mode with jj
map("i", "jj", "<Esc>")

-- Navigate visual lines (when wrapped)
map("n", "j", "gj")
map("n", "k", "gk")
map("v", "j", "gj")
map("v", "k", "gk")
map("n", "<Down>", "gj")
map("n", "<Up>", "gk")
map("v", "<Down>", "gj")
map("v", "<Up>", "gk")
map("i", "<Down>", "<C-o>gj")
map("i", "<Up>", "<C-o>gk")

-- Folding
map("n", "<Leader>fo", ":foldopen<CR>")
map("n", "<Leader>fc", ":foldclose<CR>")

-- Vim tabs
map("n", "<C-t>", ":tabnew<CR>")

-- Manually reload file
map("n", "<Leader>r", ":e!<CR>")

-- Remove search highlight with Ctrl-L
map("n", "<C-L>", ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>")

-- Toggle invisibles
map("n", "<Leader>i", ":set list!<CR>")

-- Show relative line numbers
map("n", "<Leader>l", ":set relativenumber!<CR>")

-- Close all buffers but the active one
map("n", "<Leader>bk", ":%bd <bar> e# <cr>", { desc = "Close other buffers" })
