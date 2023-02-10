-- Plugins
-- ============================================================================

require("packer").startup(function(use)
	-- package manager
	use("wbthomason/packer.nvim")

	-- color themes
	use("gruvbox-community/gruvbox")
	use("CodeGradox/onehalf-lush")

	-- regular plugins
	use("azeirah/nvim-redux")
	use("editorconfig/editorconfig-vim")
	use("f-person/auto-dark-mode.nvim")
	use("gregsexton/matchtag")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/vim-vsnip")
	use("jose-elias-alvarez/null-ls.nvim")
	use("jremmen/vim-ripgrep")
	use("leafoftree/vim-svelte-plugin")
	use("lewis6991/gitsigns.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("machakann/vim-highlightedyank")
	use("muniftanjim/prettier.nvim")
	use("neovim/nvim-lspconfig")
	use("nvim-lua/plenary.nvim")
	use("nvim-lualine/lualine.nvim")
	use("psliwka/vim-smoothie")
	-- use("raimondi/delimitmate")
	use("rishabhrd/nvim-lsputils")
	use("rishabhrd/popfix")
	use("sheerun/vim-polyglot")
	use("tmhedberg/matchit")
	use("tomtom/tcomment_vim")
	use("tpope/vim-endwise")
	use("tpope/vim-fugitive")
	use("tpope/vim-repeat")
	use("tpope/vim-rhubarb")
	use("tpope/vim-surround")
	use({
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
		},
	})
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
end)

-- Helpers
-- ============================================================================

local o = vim.opt
local g = vim.g
local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true, silent = true }

-- Important stuff to set early
-- ============================================================================

-- Disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Mappings
-- ============================================================================

-- Set leader
g.mapleader = ","

-- Remap save
map("n", "<Leader>w", ":w<CR>", mapOpts)

-- Remap exit terminal mode
map("t", "<Esc>", "<C-\\><C-n>", mapOpts)

-- Escape insert mode with jj
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

o.hlsearch = true -- highlight all results
o.incsearch = true -- but do highlight as you type your search.
o.ignorecase = true -- make searches case-insensitive...
o.smartcase = true -- ... unless they contain at least one capital letter
o.gdefault = true -- have :s///g flag by default on"

-- Visual Stuff
-- ----------------------------------------------------------------------------

o.number = true -- show line numbers
o.cursorline = true -- highlight the current line
o.history = 200 -- remember a lot of stuff
o.ruler = true -- Always show info along bottom.
o.wrap = true -- Wrap lines
o.linebreak = true -- Don't break words
o.termguicolors = true -- Enable 24-bit colors
o.signcolumn = "yes"
o.shortmess = "c"

-- Specify listchars (invisibles) with literal unicode in a :set command
vim.scriptencoding = "utf-8"
o.list = false
o.listchars = {
	tab = "▸ ",
	eol = "¬",
	trail = "·",
	space = "·",
}

-- Files
-- ----------------------------------------------------------------------------

-- auto-reload files changed on disk
o.autoread = true

-- check for changes after inactivity
vim.cmd("au CursorHold * checktime")

-- disable swap files
o.updatecount = 0
o.backup = false
o.swapfile = false

-- Indentation
-- ----------------------------------------------------------------------------

o.autoindent = true -- auto-indent
o.tabstop = 2 -- tab spacing
o.softtabstop = 2 -- unify
o.shiftwidth = 2 -- indent/outdent by 2 columns
o.expandtab = true -- use spaces instead of tabs
o.smarttab = true -- use tabs at the start of a line, spaces elsewhere
o.backspace = { "indent", "eol", "start" } -- Backspace through anything in insert mode

-- Syntaxes
-- ============================================================================

-- git (symlinked)
-- vim.cmd("au BufRead,BufNewFile gitconfig.symlink,gitignore.symlink setfiletype gitconfig")

-- JSON
-- vim.cmd("au BufRead,BufNewFile *intrc*,*.json.* set filetype=json")

-- YAML
-- vim.cmd("au BufRead,BufNewFile *.yml.*, set filetype=yaml")

-- Nunjucks
-- vim.cmd("au BufRead,BufNewFile *.nunj,*.njk set filetype=jinja.html")

-- Liquid
-- vim.cmd("au BufRead,BufNewFile *.liquid set filetype=liquid")

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
vim.cmd("set ssop-=options") -- do not store global and local values in a session
vim.cmd("set ssop-=folds") -- do not store folds

-- Make copy operations work with the clipboard
o.clipboard = "unnamed"

-- Trim trailing whitespace on save
vim.cmd("autocmd BufWritePre * :%s/\\s\\+$//e")

-- Themes
-- ============================================================================

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

-- Auto Dark Mode
-- ----------------------------------------------------------------------------

local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.fn.Gruvbox()
	end,
	set_light_mode = function()
		vim.fn.OneHalfLight()
	end,
})

auto_dark_mode.init()

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

-- mason.nvim
-- ----------------------------------------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup()

-- nvim-lspconfig
-- ----------------------------------------------------------------------------

-- nvim-cmp capabilities
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- typescript
lspconfig.tsserver.setup({
	capabilities = capabilities,
	filetypes = {
		"typescript",
		"typescriptreact",
	},
})

-- eslint
lspconfig.eslint.setup({
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
	},
})

-- cssls
lspconfig.cssls.setup({
	capabilities = capabilities,
})

-- stylelint
lspconfig.stylelint_lsp.setup({
	capabilities = capabilities,
	filetypes = {
		"css",
		"scss",
	},
})

-- svelte
lspconfig.svelte.setup({
	capabilities = capabilities,
})

-- python
lspconfig.pyright.setup({
	capabilities = capabilities,
})

-- ruby
lspconfig.solargraph.setup({
	capabilities = capabilities,
})

-- html
lspconfig.html.setup({
	capabilities = capabilities,
})

-- yaml
lspconfig.yamlls.setup({
	capabilities = capabilities,
})

-- lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- null-ls.nvim
-- ----------------------------------------------------------------------------
local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylelint,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.beautysh,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<Leader>f", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })

			-- format on save
			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
			vim.api.nvim_create_autocmd(event, {
				buffer = bufnr,
				group = group,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, async = async })
				end,
				desc = "[lsp] format on save",
			})
		end

		if client.supports_method("textDocument/rangeFormatting") then
			vim.keymap.set("x", "<Leader>f", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })
		end
	end,
})

-- prettier
-- ----------------------------------------------------------------------------
local prettier = require("prettier")

prettier.setup({
	bin = "prettier", -- or `'prettierd'` (v0.22+)
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
})

-- nvim-cmp
-- ----------------------------------------------------------------------------
vim.opt.completeopt:append("menu")
vim.opt.completeopt:append("menuone")
vim.opt.completeopt:append("noselect")

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `vsnip` users.
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "buffer" },
	}),
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping(
			cmp.mapping.complete({
				reason = cmp.ContextReason.Auto,
			}),
			{ "i", "c" }
		),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	},
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
})

-- nvim-tree
-- ----------------------------------------------------------------------------

vim.cmd("set splitright")

require("nvim-tree").setup({
	open_on_setup = false,
	open_on_setup_file = false,
	open_on_tab = false,
	view = {
		side = "left",
		mappings = {
			list = {
				{ key = { "<C-o>" }, action = "cd" },
			},
		},
	},
	filters = {
		dotfiles = false,
		exclude = { ".gitignore$", ".env" },
	},
})

map("n", "<C-n>", ":NvimTreeToggle<CR>", mapOpts)
map("n", "<C-f>", ":NvimTreeFindFile<CR>", mapOpts)

-- nvim-lsputils.nvim
-- ----------------------------------------------------------------------------
vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler

-- nvim-treesitter
-- ----------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
	-- list of languages
	ensure_installed = {
		"css",
		"html",
		"javascript",
		"json",
		"lua",
		"python",
		"ruby",
		"scss",
		"typescript",
		"yaml",
	},
	-- automatically install missing parsers when entering buffer
	auto_install = true,
	-- install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,
})

-- lualine.nvim
-- ----------------------------------------------------------------------------
require("lualine").setup()

-- telescope.vim
-- ----------------------------------------------------------------------------

local pickersOpts = {
	respect_gitignore = true,
	search_dirs = { "./", ".github/" },
}

require("telescope").setup({
	defaults = {
		prompt_prefix = "🔍 ",
	},
	pickers = {
		live_grep = pickersOpts,
		find_files = pickersOpts,
	},
})

map("n", "<C-p>", ":Telescope find_files<CR>", mapOpts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", mapOpts)
map("n", "<C-b>", ":Telescope buffers<CR>", mapOpts)
map("n", "<leader>fb", ":Telescope buffers<CR>", mapOpts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", mapOpts)

-- delimitMate
-- ----------------------------------------------------------------------------

-- vim.cmd([[
--   let delimitMate_expand_cr = 1
--   let delimitMate_matchpairs = "(:),[:],{:}"
-- ]])

-- Disable delimitMate per file type
-- vim.cmd([[
--   au FileType html.handlebars,html.mustache let b:delimitMate_autoclose = 0
-- ]])

-- Editorconfig
-- ----------------------------------------------------------------------------

vim.cmd("let g:EditorConfig_exclude_patterns = ['fugitive://.*']")

-- polyglot
-- ----------------------------------------------------------------------------

-- Don’t conceal stuff
g.vim_json_syntax_conceal = 0
g.vim_markdown_conceal = 0
g.vim_markdown_conceal_code_blocks = 0

-- indent-blankline.nvim
-- ----------------------------------------------------------------------------

g.indent_blankline_space_char = " "

-- vim-svelte-plugin
-- ----------------------------------------------------------------------------

g.vim_svelte_plugin_use_typescript = 1
