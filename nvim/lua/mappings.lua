-- Map leader to spacebar
g.mapleader = " "

-- Remap save
map("n", "<Leader>w", ":w<CR>", { desc = "Save file" })

-- Save with no autocmd
map("n", "<Leader>n", ":noa w<CR>", { desc = "Save file (no autocmd)" })

-- Quickly reload init.lua
map("n", "<Leader>sv", ":luafile ~/.config/nvim/init.lua<CR>", { desc = "Reload init.lua" })

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
map("n", "<Leader>fo", ":foldopen<CR>", { desc = "Open fold" })
map("n", "<Leader>fc", ":foldclose<CR>", { desc = "Close fold" })

-- Reload file in buffer
map("n", "<Leader>r", ":e!<CR>", { desc = "Reload file in buffer" })

-- Remove search highlight with Ctrl-L
map(
  "n",
  "<C-L>",
  ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>",
  { desc = "Remove search highlight" }
)

-- Toggle invisibles
map("n", "<Leader>i", ":set list!<CR>", { desc = "Toggle invisibles" })

-- Toggle relative line numbers
map("n", "<Leader>l", ":set relativenumber!<CR>", { desc = "Toggle relative line numbers" })
