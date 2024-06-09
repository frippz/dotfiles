return {
  "hrsh7th/nvim-cmp",
  -- load cmp on Enter
  event = "InsertEnter",
  {
    "hrsh7th/cmp-buffer",
    dependencies = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    dependencies = "nvim-cmp",
  },
  {
    "hrsh7th/cmp-vsnip",
    dependencies = "nvim-cmp",
  },
  config = function()
    vim.opt.completeopt:append("menu")
    vim.opt.completeopt:append("menuone")
    vim.opt.completeopt:append("noselect")

    require("cmp").setup({
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
  end,
}
