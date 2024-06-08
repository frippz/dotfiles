require("helpers")
require("mappings")
require("plugin")
require("themes")
require("python")

-- Important stuff to set early
-- ============================================================================

-- Disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

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

-- Files
-- ----------------------------------------------------------------------------

-- auto-reload files changed on disk
o.autoread = true

-- check for changes after inactivity
nvimCmd("au CursorHold * checktime")
nvimCmd("au FocusGained * checktime")

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

-- Plugins
-- ============================================================================

-- mason.nvim
-- ----------------------------------------------------------------------------
require("mason").setup()

-- mason-tool-installer
-- ----------------------------------------------------------------------------
require("mason-tool-installer").setup({
  ensure_installed = {
    "bash-language-server",
    "beautysh",
    "black",
    "css-lsp",
    "eslint-lsp",
    "html-lsp",
    "lua-language-server",
    "markdownlint",
    "prettierd",
    "shfmt",
    "stylelint-lsp",
    "stylua",
    "svelte-language-server",
    "typescript-language-server",
    "yaml-language-server",
  },

  start_delay = 3000, -- 3 second delay
  auto_update = true, -- check each tool for updates
  run_on_start = true, -- automatically install / update on startup
  debounce_hours = 8, -- at least 8 hours between attempts to install/update
})

-- nvim-lspconfig
-- ----------------------------------------------------------------------------

-- nvim-cmp capabilities
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- local coq = require("coq")

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

-- bash
lspconfig.bashls.setup({
  capabilities = capabilities,
})

-- cssls
lspconfig.cssls.setup({
  capabilities = capabilities,
})

-- stylelint
lspconfig.stylelint_lsp.setup({
  filetypes = { "css", "scss" },
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
-- lspconfig.svelte.setup(coq.lsp_ensure_capabilities({}))

-- swift
lspconfig.sourcekit.setup({
  capabilities = capabilities,
})

-- python
lspconfig.pyright.setup({
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

-- coq_nvim
-- ----------------------------------------------------------------------------
g.coq_settings = {
  auto_start = true,
  keymap = {
    jump_to_mark = "<tab>",
  },
}

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

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "<C-o>", api.tree.change_root_to_node, opts("CD"))
end

require("nvim-tree").setup({
  view = {
    side = "left",
  },
  filters = {
    dotfiles = false,
    exclude = { ".gitignore$", ".env" },
  },
  on_attach = on_attach,
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
require("lualine").setup({
  options = {
    theme = "everforest",
  },
})

-- gitsigns.nvim
-- ----------------------------------------------------------------------------
require("gitsigns").setup()

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

-- nvim-treesitter
-- ----------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "css",
    "diff",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "javascript",
    "jsdoc",
    "svelte",
    "typescript",
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
})

-- nvim-ts-context-commentstring
-- ----------------------------------------------------------------------------
require("ts_context_commentstring").setup()

-- comment.nvim
-- ----------------------------------------------------------------------------
require("Comment").setup()

-- vim-fugitive
-- ----------------------------------------------------------------------------
map("n", "<Leader>fgb", ":G blame<CR>", mapOpts)

-- fterm.nvim
-- ----------------------------------------------------------------------------
require("FTerm").setup({})

-- mappings
map("n", "<Leader>t", ":lua require('FTerm').toggle()<CR>", mapOpts)

-- notify.nvim
-- ----------------------------------------------------------------------------
require("notify").setup({
  background_colour = "#000000",
  timeout = 3000,
  top_down = false,
})

-- noice.nvim
-- ----------------------------------------------------------------------------
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

-- transparent.nvim
-- ----------------------------------------------------------------------------
require("transparent").setup({
  groups = {
    "Normal",
    "NormalNC",
    "Comment",
    "Constant",
    "Special",
    "Identifier",
    "Statement",
    "PreProc",
    "Type",
    "Underlined",
    "Todo",
    "String",
    "Function",
    "Conditional",
    "Repeat",
    "Operator",
    "Structure",
    "LineNr",
    "NonText",
    "SignColumn",
    "CursorLineNr",
    "StatusLine",
    "StatusLineNC",
    "EndOfBuffer",
  },
  extra_groups = {},
  exclude_groups = { "CursorLine" },
})

vim.g.transparent_enabled = true

-- bool-switcher
-- ----------------------------------------------------------------------------
require("bool-switcher").setup("<Leader>bt")
