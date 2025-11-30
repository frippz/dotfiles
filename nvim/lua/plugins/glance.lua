--  Peek preview window for LSP locations in Neovim
return {
  "DNLHC/glance.nvim",

  cmd = "Glance",

  keys = {
    {
      "<Leader>gd",
      ":Glance definitions<cr>",
      desc = "Glance definitions",
    },
    {
      "<Leader>gi",
      ":Glance implementations<cr>",
      desc = "Glance implementations",
    },
    {
      "<Leader>gr",
      ":Glance references<cr>",
      desc = "Glance references",
    },
    {
      "<Leader>gt",
      ":Glance type_definitions<cr>",
      desc = "Glance type definitions",
    },
  },

  opts = {

    -- Quickfix action will open trouble.nvim instead of built-in
    use_trouble_qf = false,

    -- Show nice solid lines above and below preview
    border = {
      enable = true,
      top_char = "–",
      bottom_char = "–",
    },
  },
}
