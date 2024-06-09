return {
  "ms-jpq/coq_nvim",
  config = function()
    g.coq_settings = {
      auto_start = true,
      keymap = {
        jump_to_mark = "<tab>",
      },
    }
  end,
}
