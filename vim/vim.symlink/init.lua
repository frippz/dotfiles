-- Plugins
-- ============================================================================
local paq = require("paq")

paq({
  -- package manager
  "savq/paq-nvim",

  -- color themes
  "gruvbox-community/gruvbox",
  "rktjmp/lush.nvim",
  "CodeGradox/onehalf-lush",

  -- regular plugins
  "amadeus/vim-convert-color-to",
  "editorconfig/editorconfig-vim",
  "evanleck/vim-svelte",
  "f-person/auto-dark-mode.nvim",
  "godlygeek/tabular",
  "gregsexton/MatchTag",
  "jremmen/vim-ripgrep",
  "kyazdani42/nvim-tree.lua",
  "kyazdani42/nvim-web-devicons",
  "lewis6991/gitsigns.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "machakann/vim-highlightedyank",
  "norcalli/nvim-colorizer.lua",
  "nvim-lua/plenary.nvim",
  "psliwka/vim-smoothie",
  "raimondi/delimitMate",
  "ryanoasis/vim-devicons",
  "sheerun/vim-polyglot",
  "tmhedberg/matchit",
  "tommcdo/vim-fubitive",
  "tomtom/tcomment_vim",
  "tpope/vim-endwise",
  "tpope/vim-fugitive",
  "tpope/vim-liquid",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  { "neoclide/coc.nvim", branch = "release" },
  { "nvim-telescope/telescope.nvim", branch = "0.1.x" },

  -- Maybe keep?
  -- "mattn/emmet-vim",
  -- "wsdjeg/vim-fetch",
})

-- Helpers
-- ============================================================================

local o = vim.opt
local g = vim.g
local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true, silent = true }

-- Mappings
-- ============================================================================

-- Set leader
g.mapleader = ","

-- Remap save
map("n", "<Leader>w", ":w<CR>", mapOpts)

-- Remap exit terminal mode
map("t", "<Esc>", "<C-\\><C-n>", mapOpts)

-- Escape insert mode with jj 😱
map("i", "jj", "<Esc>", mapOpts)

-- Map netrw to Ctrl-E
map("n", "<C-E>", ":Ex<CR>", mapOpts)

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

-- Misc
-- ============================================================================

--  Live substitution
o.inccommand = "nosplit"

-- Search
-- ----------------------------------------------------------------------------
o.hlsearch = true        -- highlight all results
o.incsearch  = true      -- but do highlight as you type your search.
o.ignorecase = true      -- make searches case-insensitive...
o.smartcase = true       -- ... unless they contain at least one capital letter
o.gdefault = true        -- have :s///g flag by default on"

-- Visual Stuff
-- ----------------------------------------------------------------------------
o.number = true          -- show line numbers
o.cursorline = true      -- highlight the current line
o.history = 200          -- remember a lot of stuff
o.ruler = true           -- Always show info along bottom.
o.wrap = true            -- Wrap lines
o.linebreak = true       -- Don't break words

-- Specify listchars (invisibles) with literal unicode in a :set command
vim.scriptencoding = "utf-8"
o.list = false
o.listchars = {
  tab = "▸ ",
  eol = "¬",
  trail = "·",
  space = "·"
}

-- Files
-- ----------------------------------------------------------------------------

-- auto-reload files changed on disk
o.autoread = true

-- check for changes after inactivity
vim.cmd("au CursorHold * checktime")

-- disable swap files
o.updatecount = 0
-- o.nobackup = true
-- o.noswapfile = true

-- Indentation
-- ----------------------------------------------------------------------------

o.autoindent = true      -- auto-indent
o.tabstop = 2            -- tab spacing
o.softtabstop = 2        -- unify
o.shiftwidth = 2         -- indent/outdent by 2 columns
-- o.noshiftround = true    -- don’t indent/outdent to the nearest tabstop
o.expandtab = true       -- use spaces instead of tabs
o.smarttab = true        -- use tabs at the start of a line, spaces elsewhere
o.backspace = {"indent", "eol", "start"} -- Backspace through anything in insert mode


-- Syntaxes
-- ============================================================================

-- git (symlinked)
vim.cmd("au BufRead,BufNewFile gitconfig.symlink,gitignore.symlink setfiletype gitconfig")

-- nginx
vim.cmd("au BufRead,BufNewFile */nginx/*,nginx.conf set filetype=nginx")

-- JSON
vim.cmd("au BufRead,BufNewFile *intrc*,*.json.* set filetype=json")

-- YAML
vim.cmd("au BufRead,BufNewFile *.yml.*, set filetype=yaml")

-- Nunjucks
vim.cmd("au BufRead,BufNewFile *.nunj,*.njk set filetype=jinja.html")

-- Liquid
vim.cmd("au BufRead,BufNewFile *.liquid set filetype=liquid")

-- Dockerfile
vim.cmd("au BufRead,BufNewFile Dockerfile* set filetype=dockerfile")

-- Vue
vim.cmd("let g:vue_pre_processors = []")

-- Miscellaneous
-- ============================================================================

-- Enable mouse
o.mouse = "a"

-- Disable delays for <Leader>
o.timeoutlen = 1000
o.ttimeout = true
o.ttimeoutlen = 0

-- Use relative line numbers
o.relativenumber = true

-- " Default netrw list style
g.netrw_liststyle = 3

-- Per default, netrw leaves unmodified buffers open. This autocommand
-- deletes netrw's buffer once it's hidden (using ':q', for example)
vim.cmd("autocmd FileType netrw setl bufhidden=delete")

-- Disable netrwhist
g.netrw_dirhistmax = 0

-- Session options
vim.cmd("set ssop-=options")  -- do not store global and local values in a session
vim.cmd("set ssop-=folds")    -- do not store folds

-- Make copy operations work with the clipboard
o.clipboard = "unnamed"

-- Trim trailing whitespace on save
vim.cmd("autocmd BufWritePre * :%s/\\s\\+$//e")

-- Themes
-- ============================================================================

-- Auto Dark Mode
-- ----------------------------------------------------------------------------
local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
  update_interval = 1000,
  set_dark_mode = function()
    o.background = "dark"
    vim.cmd("syntax enable")
    vim.cmd("colorscheme gruvbox")
    vim.cmd("highlight! link SignColumn LineNr")
    -- Set transparent background
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    -- Italic comments
    vim.cmd("highlight Comment cterm=italic gui=italic")
  end,
  set_light_mode = function()
    o.background = "light"
    vim.cmd("syntax enable")
    vim.cmd("colorscheme onehalf-lush")
    vim.cmd("highlight! link SignColumn LineNr")
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
  end,
})

auto_dark_mode.init()

-- Gruvbox
-- ----------------------------------------------------------------------------
vim.cmd([[
  function! Gruvbox()
    syntax enable
    set background=dark
    colorscheme gruvbox
    highlight! link SignColumn LineNr
    hi Normal guibg=NONE ctermbg=NONE
    highlight Comment cterm=italic gui=italic
  endfunction
]])

-- OneHalf Light
-- ----------------------------------------------------------------------------
vim.cmd([[
  function! OneHalfLight()
    syntax enable
    set background=light
    colorscheme onehalf-lush
    highlight! link SignColumn LineNr
    hi Normal guibg=NONE ctermbg=NONE
    highlight Comment cterm=italic gui=italic
  endfunction
]])

-- Theming for non-macOS
-- Set theme based on $TERM_THEME (or fall back to Gruvbox)
-- ----------------------------------------------------------------------------
vim.cmd([[
  if !has('macunix')
    if $TERM_THEME == 'light'
      call OneHalfLight()
    else
      call Gruvbox()
    endif
  endif
]])

-- Plugins
-- ============================================================================

-- Convert Color
-- ----------------------------------------------------------------------------
map("n", "<leader>c", ":ConvertColorTo hsl<CR>", mapOpts)

-- Colorizer
-------------------------------------------------------------------------------
o.termguicolors = true
require("colorizer").setup()

-- nvim-tree
-- ----------------------------------------------------------------------------
vim.cmd("set splitright")

require("nvim-tree").setup({
  view = {
    side = "left"
  },
  filters = {
    dotfiles = false,
    exclude = { ".gitignore$", ".env" }
  }
})

map("n", "<C-n>", ":NvimTreeToggle<CR>", mapOpts)
map("n", "<C-f>", ":NvimTreeFindFile<CR>", mapOpts)

-- telescope.vim
-- ----------------------------------------------------------------------------
require("telescope").setup({
  defaults = {
    prompt_prefix = "🔍 "
  }
})

-- show telescope on Ctrl-P
map("n", "<C-p>", ":Telescope find_files<CR>", mapOpts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", mapOpts)
map("n", "<leader>fb", ":Telescope buffers<CR>", mapOpts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", mapOpts)

-- coc.nvim
-- ----------------------------------------------------------------------------

-- Extensions
-- :CocInstall coc-html coc-css coc-git coc-svg coc-json coc-yaml coc-emmet coc-tsserver coc-prettier coc-stylelintplus

vim.cmd([[
  set updatetime=300
  set shortmess+=c
  set signcolumn=yes

  let g:echodoc_enable_at_startup = 1

  " coc-prettier
  command! -nargs=0 Prettier :CocCommand prettier.formatFile
  vmap <Leader>f  <Plug>(coc-format-selected)
  nmap <Leader>f  <Plug>(coc-format-selected)

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice.
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call ShowDocumentation()<CR>

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)
]])

-- delimitMate
-- ----------------------------------------------------------------------------
vim.cmd([[
  let delimitMate_expand_cr = 1
  let delimitMate_matchpairs = "(:),[:],{:}"
]])

-- Disable delimitMate per file type
vim.cmd([[
  au FileType html.handlebars,html.mustache let b:delimitMate_autoclose = 0
]])

-- Editorconfig
-- ----------------------------------------------------------------------------
vim.cmd("let g:EditorConfig_exclude_patterns = ['fugitive://.*']")

-- polyglot
-- ----------------------------------------------------------------------------

-- " Don’t conceal stuff
g.vim_json_syntax_conceal = 0
g.vim_markdown_conceal = 0
g.vim_markdown_conceal_code_blocks = 0

-- indent-blankline.nvim
-- ----------------------------------------------------------------------------
g.indent_blankline_space_char = " "