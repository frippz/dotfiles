-- Map leader to spacebar
g.mapleader = " "

-- Remap save
map("n", "<Leader>w", ":w<CR>", mapOpts)

-- Save with no autocmd
map("n", "<Leader>n", ":noa w<CR>", mapOpts)

-- Quickly reload init.lua
map("n", "<Leader>sv", ":luafile ~/.config/nvim/init.lua<CR>", mapOpts)

-- Remap exit terminal mode
map("t", "<Esc>", "<C-\\><C-n>", mapOpts)

-- Escape insert mode with jj
map("i", "jj", "<Esc>", mapOpts)

-- Navigate visual lines (when wrapped)
map("n", "j", "gj", mapOpts)
map("n", "k", "gk", mapOpts)
map("v", "j", "gj", mapOpts)
map("v", "k", "gk", mapOpts)
map("n", "<Down>", "gj", mapOpts)
map("n", "<Up>", "gk", mapOpts)
map("v", "<Down>", "gj", mapOpts)
map("v", "<Up>", "gk", mapOpts)
map("i", "<Down>", "<C-o>gj", mapOpts)
map("i", "<Up>", "<C-o>gk", mapOpts)

-- Folding
map("n", "<Leader>fo", ":foldopen<CR>", mapOpts)
map("n", "<Leader>fc", ":foldclose<CR>", mapOpts)

-- Vim tabs
map("n", "<C-t>", ":tabnew<CR>", mapOpts)

-- Manually reload file
map("n", "<Leader>r", ":e!<CR>", mapOpts)

-- Remove search highlight with Ctrl-L
map("n", "<C-L>", ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>", mapOpts)

-- Toggle invisibles
map("n", "<Leader>i", ":set list!<CR>", mapOpts)

-- Show relative line numbers
map("n", "<Leader>l", ":set relativenumber!<CR>", mapOpts)

-- LSP mappings
map("n", "gd", ":lua vim.lsp.buf.definition()<CR>", mapOpts)
map("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", mapOpts)
map("n", "gI", ":lua vim.lsp.buf.implementation()<CR>", mapOpts)
map("n", "gr", ":lua vim.lsp.buf.references()<CR>", mapOpts)
map("n", "K", ":lua vim.lsp.buf.hover()<CR>", mapOpts)
map("n", "gs", ":lua vim.lsp.buf.signature_help()<CR>", mapOpts)
map("n", "<Leader>rn", ":lua vim.lsp.buf.rename()<CR>", mapOpts)
map("n", "<Leader>d", ":lua vim.diagnostic.open_float()<CR>", mapOpts)
map("n", "<Leader>ca", ":lua vim.lsp.buf.code_action()<CR>", mapOpts)
