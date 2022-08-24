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
  'alvan/vim-closetag',
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
  'mattn/emmet-vim',
  'mileszs/ack.vim',
  { 'neoclide/coc.nvim', branch = "release" },
  'norcalli/nvim-colorizer.lua',
  'nvim-lua/plenary.nvim',
  'psliwka/vim-smoothie',
  'raimondi/delimitMate',
  'ryanoasis/vim-devicons',
  'sheerun/vim-polyglot',
  'skwp/greplace.vim',
  'tmhedberg/matchit',
  'tommcdo/vim-fubitive',
  'tomtom/tcomment_vim',
  'tpope/vim-endwise',
  'tpope/vim-eunuch',
  'tpope/vim-fugitive',
  'tpope/vim-liquid',
  'tpope/vim-repeat',
  'tpope/vim-rhubarb',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'wsdjeg/vim-fetch',
  { "nvim-telescope/telescope.nvim", branch = "0.1.x" },

})

-- Helpers
-- ============================================================================

-- convenience shortcut for keyboard mappings
local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true, silent = true }

-- Misc
-- ============================================================================

-- Truecolor support
vim.cmd([[
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
]])

-- " Live substitution
vim.cmd([[
  set inccommand=nosplit
]])

-- Mappings
-- ============================================================================

-- Set leader
vim.g.mapleader = ","

-- Remap exit terminal mode
vim.cmd([[
  tnoremap <Esc> <C-\><C-n>
]])

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

-- Gruvbox {{
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
-- }}

-- OneHalf Light {{
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
-- }}

-- Theming for non-macOS {{
vim.cmd([[ 
  if !has('macunix')

    " Set theme based on $TERM_THEME (or fall back to Gruvbox)
    if $TERM_THEME == 'light'
      call OneHalfLight()
    else
      call Gruvbox()
    endif

  endif
]])
-- }}

-- Plugins
-- ============================================================================

-- Convert Color
-------------------------------------------------------------------------------
vim.cmd([[
  nnoremap <leader>c :ConvertColorTo hsl<CR>
]])

-- Colorizer
-------------------------------------------------------------------------------
vim.cmd("set termguicolors")
require("colorizer").setup()

-- Closetag
-------------------------------------------------------------------------------
vim.cmd([[
  let g:closetag_filenames = "*.html,*.tpl"
]])

-- GitGutter
-------------------------------------------------------------------------------
vim.cmd([[
  let g:gitgutter_async = 1
  let g:gitgutter_sign_removed_first_line = "^_"
]])

-- nvim-tree
-------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------
require("telescope").setup()

-- show telescope on Ctrl-P
map("n", "<C-p>", ":Telescope find_files<CR>", mapOpts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", mapOpts)
map("n", "<leader>fb", ":Telescope buffers<CR>", mapOpts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", mapOpts)
