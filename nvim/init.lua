require("plugins")

-- Helpers
-- ============================================================================
local o = vim.opt
local g = vim.g
local map = vim.api.nvim_set_keymap
local nvimCmd = vim.api.nvim_command
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
nvimCmd("au CursorHold * checktime")

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

-- Disable netrwhist
g.netrw_dirhistmax = 0

-- Session options
nvimCmd("set ssop-=options") -- do not store global and local values in a session
nvimCmd("set ssop-=folds") -- do not store folds

-- Make copy operations work with the clipboard
o.clipboard = "unnamed"

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- Themes
-- ============================================================================
nvimCmd("syntax enable")
nvimCmd("highlight! link SignColumn LineNr")
nvimCmd("hi Normal guibg=NONE ctermbg=NONE")
nvimCmd("highlight Comment cterm=italic gui=italic")

-- Dark
-- ----------------------------------------------------------------------------
function ThemeDark()
	o.background = "dark"
	g.gruvbox_material_better_performance = 1
	g.gruvbox_material_enable_bold = 1
	g.gruvbox_material_dim_inactive_windows = 0
	g.gruvbox_material_transparent_background = "1"
	nvimCmd("colorscheme gruvbox-material")
end

-- Light
-- ----------------------------------------------------------------------------
function ThemeLight()
	o.background = "light"
	nvimCmd("colorscheme one-nvim")
end

-- Auto Dark Mode
-- ----------------------------------------------------------------------------
local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		ThemeDark()
	end,
	set_light_mode = function()
		ThemeLight()
	end,
})

auto_dark_mode.init()

-- Theming for non-macOS
-- Set theme based on $TERM_THEME (or fall back to Gruvbox)
-- ----------------------------------------------------------------------------
nvimCmd([[
  if !has('macunix')
    if $TERM_THEME == 'light'
      call ThemeLight()
    else
      call ThemeDark()
    endif
  endif
]])

-- Plugins
-- ============================================================================

-- null-ls.nvim
-- ----------------------------------------------------------------------------
local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettierd,
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

-- mason.nvim
-- ----------------------------------------------------------------------------
local mason_null_ls = require("mason-null-ls")

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"cssls",
		"tsserver",
		"eslint",
		"html",
	},
	automatic_installation = true,
})

mason_null_ls.setup({
	ensure_installed = {
		"beautysh",
		"css-lsp",
		"cssmodules-language-server",
		"html-lsp",
		"lua-language-server",
		"markdownlint",
		"prettierd",
		"rubocop",
		"stylelint-lsp",
		"stylua",
		"svelte-language-server",
		"typescript-language-server",
	},
	automatic_setup = true,
})
mason_null_ls.setup_handlers()

-- nvim-lspconfig
-- ----------------------------------------------------------------------------

-- nvim-cmp capabilities
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- typescript
lspconfig.tsserver.setup({
	capabilities = capabilities,
})

-- eslint
lspconfig.eslint.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

-- cssls
lspconfig.cssls.setup({
	capabilities = capabilities,
})

-- stylelint
lspconfig.stylelint_lsp.setup({
	settings = {
		stylelintplus = {
			autoFixOnSave = true,
			autoFixOnFormat = true,
		},
	},
	capabilities = capabilities,
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

-- trouble.nvim
-- ----------------------------------------------------------------------------
require("trouble").setup({})

-- mappings
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", mapOpts)
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", mapOpts)
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", mapOpts)
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", mapOpts)
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", mapOpts)
map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", mapOpts)

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

-- nvim-tree
-- ----------------------------------------------------------------------------
nvimCmd("set splitright")

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

-- lualine.nvim
-- ----------------------------------------------------------------------------
require("lualine").setup({})

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

map("n", "<C-p>", ":Telescope find_files hidden=true<CR>", mapOpts)
map("n", "<C-b>", ":Telescope buffers<CR>", mapOpts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", mapOpts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", mapOpts)

-- gitsigns.nvim
-- ----------------------------------------------------------------------------
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "±" },
		delete = { text = "-" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
})

-- delimitMate
-- ----------------------------------------------------------------------------
nvimCmd([[
  let delimitMate_expand_cr = 1
  let delimitMate_matchpairs = "(:),[:],{:}"
]])

-- Disable delimitMate per file type
nvimCmd([[
  au FileType html.handlebars,html.mustache let b:delimitMate_autoclose = 0
]])

-- indent-blankline.nvim
-- ----------------------------------------------------------------------------
g.indent_blankline_space_char = " "

-- nvim-treesitter
-- ----------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"css",
		"gitcommit",
		"gitignore",
		"javascript",
		"svelte",
		"typescript",
	},
	auto_install = true,
	highlight = {
		enable = true,
	},
})
