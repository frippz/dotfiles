-- Package management & Plugins
-- ============================================================================
local paq = require("paq")

paq({

  -- package manager
	'savq/paq-nvim',

  -- color themes
  'gruvbox-community/gruvbox',
  'rktjmp/lush.nvim',
  'CodeGradox/onehalf-lush',

  -- regular plugins
  'amadeus/vim-convert-color-to',
  'editorconfig/editorconfig-vim',
  'evanleck/vim-svelte',
  'f-person/auto-dark-mode.nvim',
  'godlygeek/tabular',
  'gregsexton/MatchTag',
  'jremmen/vim-ripgrep',
  'kyazdani42/nvim-tree.lua',
  'kyazdani42/nvim-web-devicons',
  'lewis6991/gitsigns.nvim',
  'lukas-reineke/indent-blankline.nvim',
  'machakann/vim-highlightedyank',
  { 'neoclide/coc.nvim', branch = "release" },
  'norcalli/nvim-colorizer.lua',
  'psliwka/vim-smoothie',
  'raimondi/delimitMate',
  'ryanoasis/vim-devicons',
  'sheerun/vim-polyglot',
  'tmhedberg/matchit',
  'tommcdo/vim-fubitive',
  'tomtom/tcomment_vim',
  'tpope/vim-endwise',
  'tpope/vim-fugitive',
  'tpope/vim-liquid',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x' },

  -- Maybe keep?
  -- 'alvan/vim-closetag',
  -- 'mattn/emmet-vim',
  -- 'nvim-lua/plenary.nvim',
  -- 'wsdjeg/vim-fetch',

})

-- Helpers
-- ============================================================================

local o = vim.o
local g = vim.g
local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true, silent = true }

-- Misc
-- ============================================================================

-- " Live substitution
o.inccommand = "nosplit"

-- Mappings
-- ============================================================================

-- Set leader
g.mapleader = ","

-- Remap exit terminal mode
map("n", "<Esc>", "<C-\><C-n>", mapOpts)

-- Themes
-- ============================================================================

-- Auto Dark Mode {{
-- ----------------------------------------------------------------------------
local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
  update_interval = 1000,
  set_dark_mode = function()
    vim.api.nvim_set_option('background', 'dark')
    vim.cmd('syntax enable')
    vim.cmd('colorscheme gruvbox')
    vim.cmd('highlight! link SignColumn LineNr')
    -- Set transparent background
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    -- Italic comments
    vim.cmd('highlight Comment cterm=italic gui=italic')
  end,
  set_light_mode = function()
    vim.api.nvim_set_option('background', 'light')
    vim.cmd('syntax enable')
    vim.cmd('colorscheme onehalf-lush')
    vim.cmd('highlight! link SignColumn LineNr')
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
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
map('n', '<leader>c', ':ConvertColorTo hsl<CR>', mapOpts)

-- Colorizer
-------------------------------------------------------------------------------
o.termguicolors = true
require('colorizer').setup()

-- Closetag
-- ----------------------------------------------------------------------------
-- vim.cmd([[
--   let g:closetag_filenames = "*.html,*.tpl"
-- ]])

-- nvim-tree
-- ----------------------------------------------------------------------------
vim.cmd("set splitright")

require("nvim-tree").setup({
  view = {
    side = 'left'
  },
  filters = {
    dotfiles = false,
  }
})

map("n", "C-n", ":NvimTreeToggle<CR>", mapOpts)
map("n", "C-f", ":NvimTreeFindFile<CR>", mapOpts)

-- telescope.vim
-- ----------------------------------------------------------------------------
require("telescope").setup({
  pickers = {
    find_files = {
      theme = "dropdown",
    },
  },
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
o.delimitMate_expand_cr = '1'
o.delimitMate_matchpairs = '(:),[:],{:}'

-- Disable delimitMate per file type
vim.cmd("au FileType html.handlebars,html.mustache let b:delimitMate_autoclose = 0")

-- Editorconfig
-- ----------------------------------------------------------------------------
vim.cmd("let g:EditorConfig_exclude_patterns = ['fugitive://.*']")
