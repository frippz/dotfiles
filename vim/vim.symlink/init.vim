" Plugin Manager
" ===========================================================================

call plug#begin('~/.vim/plugged')

" Color themes
Plug 'gruvbox-community/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Regular plugins
Plug 'alvan/vim-closetag'
Plug 'amadeus/vim-convert-color-to'
Plug 'editorconfig/editorconfig-vim'
Plug 'evanleck/vim-svelte'
Plug 'f-person/auto-dark-mode.nvim'
Plug 'godlygeek/tabular'
Plug 'gregsexton/MatchTag'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'psliwka/vim-smoothie'
Plug 'raimondi/delimitMate'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'skwp/greplace.vim'
Plug 'tmhedberg/matchit'
Plug 'tommcdo/vim-fubitive'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wsdjeg/vim-fetch'

call plug#end()

" General
" ===========================================================================

" Set leader
let mapleader = ","

" NeoVim only features
" ===========================================================================

if has('nvim')

  " True color support
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " Remap exit terminal mode
  tnoremap <Esc> <C-\><C-n>

  " Live substitution
  set inccommand=nosplit

endif

" Themes
" ===========================================================================

" Auto Dark Mode {{
lua require("autodarkmode")
" }}


" Gruvbox {{
function! Gruvbox()
  syntax enable
  set background=dark
  colorscheme gruvbox
  highlight! link SignColumn LineNr
  " Set transparent background
  hi Normal guibg=NONE ctermbg=NONE
  " Italic comments
  highlight Comment cterm=italic gui=italic
endfunction
" }}

" OneHalf Light {{
function! OneHalfLight()
  syntax enable
  set background=light
  colorscheme onehalflight
  highlight! link SignColumn LineNr
  " Set transparent background
  hi Normal guibg=NONE ctermbg=NONE
endfunction

" Theming for non-macOS {{
if !has('macunix')

  " Set theme based on $TERM_THEME (or fall back to Gruvbox)
  if $TERM_THEME == 'light'
    call OneHalfLight()
  else
    call Gruvbox()
  endif

endif
"}}

" Plugins
" ===========================================================================

" Convert Color {{
nnoremap <leader>c :ConvertColorTo hsl<CR>
" }}

" Colorizer {{
set termguicolors
lua require'colorizer'.setup()
" }}

" fzf {{
set rtp+=~/.fzf

" Open with Ctrl-P
nmap <C-p> :Files<CR>

nmap <C-b> :Buffers<CR>

lua require("fzf")

autocmd! FileType fzf
autocmd  FileType fzf set nonu nornu

" Allow closing FZF with esc
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

" Set environment variables
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let $FZF_DEFAULT_OPTS='--layout=reverse'

let g:fzf_layout = {
  \ 'window': {
    \ 'width': 0.8,
    \ 'height': 0.9,
    \ 'border': 'sharp'
  \ }
\ }

 " Open fzf Files
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(blue)%C(bold)%cr%C(white)"'
" }}

" Closetag {{
let g:closetag_filenames = "*.html,*.tpl"
" }}

" GitGutter {{

" Make GitGutter work in NeoVim.
let g:gitgutter_async = 1
let g:gitgutter_sign_removed_first_line = "^_"
" }}

" nvim-tree {{

" make sure nvim-tree opens files correctly in new windows
set splitright

lua << EOF
require("nvim-tree").setup({
  view = {
    side = 'left'
  },
  filters = {
    dotfiles = false,
  }
})
EOF

" Toggle with Ctrl-N
map <C-n> :NvimTreeToggle<CR>
nnoremap <C-f> :NvimTreeFindFile<CR>

" }}

" coc.nvim {{

" Extensions
" :CocInstall coc-html coc-css coc-git coc-svg coc-json coc-yaml coc-emmet coc-tsserver coc-prettier coc-stylelintplus
set updatetime=300
set shortmess+=c
set signcolumn=yes

let g:echodoc_enable_at_startup = 1

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <Leader>f  <Plug>(coc-format-selected)
nmap <Leader>f  <Plug>(coc-format-selected)

" Mappings

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

" }}

" delimitMate {{
let delimitMate_expand_cr = 1
let delimitMate_matchpairs = "(:),[:],{:}"

" Disable delimitMate per file type
au FileType html.handlebars,html.mustache let b:delimitMate_autoclose = 0
" }}

" Editorconfig {{
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" }}

" Greplace {{
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'
" }}

" polyglot {{

" Don’t conceal stuff
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
" }}

" indent-blankline.nvim {{
let g:indent_blankline_space_char = ' '
" }}

" Search
" ===========================================================================
set hlsearch                " highlight all results
set incsearch               " but do highlight as you type your search.
set ignorecase              " make searches case-insensitive...
set smartcase               " ... unless they contain at least one capital letter
set gdefault                " have :s///g flag by default on"

" Remove search highlight with Ctrl-L
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Visual Stuff
" ===========================================================================
set number                  " show line numbers
set cursorline              " highlight the current line
set history=200             " remember a lot of stuff
set ruler                   " Always show info along bottom.
set wrap                    " Wrap lines
set linebreak               " Don't break words

" Specify listchars (invisibles) with literal unicode in a :set command
scriptencoding utf-8
set list lcs=tab:▸\ ,eol:¬,trail:·,space:·
set nolist

" Map toggle invisibles
nnoremap <Leader>i :set list!<CR>

" Code folding
" ===========================================================================

" Make sure folding does not occur automatically
set foldlevelstart=99

" Fold by indent level
set foldmethod=indent

" Files
" ===========================================================================

" auto-reload files changed on disk
set autoread

" check for changes after inactivity
au CursorHold * checktime

" disable swap files
set updatecount=0
set nobackup
set noswapfile

" Indentation
" ===========================================================================

set autoindent                 " auto-indent
set tabstop=2                  " tab spacing
set softtabstop=2              " unify
set shiftwidth=2               " indent/outdent by 2 columns
set noshiftround               " don’t indent/outdent to the nearest tabstop
set expandtab                  " use spaces instead of tabs
set smarttab                   " use tabs at the start of a line, spaces elsewhere
set backspace=indent,eol,start " Backspace through anything in insert mode

" allow toggling between local and default mode
function! TabToggle()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
  else
    set shiftwidth=2
    set softtabstop=2
    set expandtab
  endif
endfunction
nmap <F9> mz:execute TabToggle()<CR>'z

" Syntaxes
" ===========================================================================

" git (symlinked)
au BufRead,BufNewFile gitconfig.symlink,gitignore.symlink setfiletype gitconfig

" nginx
au BufRead,BufNewFile */nginx/*,nginx.conf set filetype=nginx

" JSON
au BufRead,BufNewFile *intrc*,*.json.* set filetype=json

" YAML
au BufRead,BufNewFile *.yml.*, set filetype=yaml

" Nunjucks
au BufRead,BufNewFile *.nunj,*.njk set filetype=jinja.html

" Liquid
au BufRead,BufNewFile *.liquid set filetype=liquid

" Dockerfile
au BufRead,BufNewFile Dockerfile* set filetype=dockerfile

" Vue
let g:vue_pre_processors = []

" Misc
" ===========================================================================

" Enable mouse
set mouse=a

" Disable delays for <Leader>
set timeoutlen=1000
set ttimeout
set ttimeoutlen=0

" Use relative line numbers
set relativenumber
nnoremap <Leader>l :set relativenumber!<CR>

" Default netrw list style
let g:netrw_liststyle=3

" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'

" Hide invisibles in netrw and NERDTree
autocmd FileType netrw setlocal nolist
autocmd FileType nerdtree setlocal nolist

" Disable signcolumn in NERDTree
autocmd FileType nerdtree setlocal signcolumn=no

" Hide files from netrw and NERDTree
let g:netrw_list_hide= '.*\.DS_Store$,node_modules,^\.git$,\.cache'
let NERDTreeIgnore = ['.DS_Store$', 'node_modules', '\.git$', '.cache']

" Map netrw to Ctrl-E
nnoremap <C-E> :Ex<CR>

" Disable netrwhist
let g:netrw_dirhistmax = 0

" Remap some common actions
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :CtrlP<CR>

" Escape insert mode with jj 😱
imap jj <Esc>

" Session options
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

" Make copy operations work with the clipboard
set clipboard=unnamed

" Trim trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Navigate visual lines (when wrapped)
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Vim tabs
map <C-t> :tabnew <CR>

" Manually reload file
map <Leader>r :e!<CR>