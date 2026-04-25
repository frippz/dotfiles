-- Tree-sitter integration for Neovim.
-- Using the `main` branch (rewrite): no more `configs.setup()`, no more
-- `ensure_installed`/`highlight` table. Parsers are installed explicitly,
-- and highlighting is started per-buffer via `vim.treesitter.start()`.

local parsers = {
  "astro",
  "css",
  "diff",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "javascript",
  "jsdoc",
  "lua",
  "markdown",
  "markdown_inline", -- needed alongside `markdown` for proper rendering
  "regex",
  "scss",
  "svelte",
  "typescript",
  "tsx",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,

  config = function()
    -- Install (or update) the parsers we care about.
    require("nvim-treesitter").install(parsers)

    -- Start treesitter highlighting whenever we open a file with a parser.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        local ft = vim.bo[ev.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        if not pcall(vim.treesitter.start, ev.buf, lang) then
          return
        end
        -- Optional: treesitter-based folds + indent
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
