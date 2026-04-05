require("vim._core.ui2").enable({
  enable = true, -- Whether to enable or disable the UI.

  -- Options related to the message module.
  msg = {

    ---@type string|table<string, 'cmd'|'msg'|'pager'>
    targets = {
      default = "cmd",
      bufread = "msg",
      bufwrite = "msg",
      bufnewfile = "msg",
      progress = "msg",
    },

    cmd = { -- Options related to messages in the cmdline window.
      height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
    },

    dialog = { -- Options related to dialog window.
      height = 0.5, -- Maximum height.
    },

    msg = { -- Options related to msg window.
      height = 0.7, -- Maximum height.
      timeout = 4000, -- Time a message is visible in the message window.
    },

    pager = { -- Options related to message window.
      height = 1, -- Maximum height.
    },
  },
})
