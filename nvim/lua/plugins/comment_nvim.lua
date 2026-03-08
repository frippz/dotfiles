-- Smart and Powerful commenting

return {
  "numtostr/comment.nvim",

  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },

  config = function()
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
      languages = {
        astro = "{/* %s */}", -- use JS style comments in template
      },
    })

    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
