local helper = require("core.helper")
local catppuccin = helper.safe_require("catppuccin")

catppuccin.setup({
  background = { -- :h background
        light = "latte",
        dark = "mocha",
  },
  no_italic = true,
})

vim.cmd.colorscheme 'catppuccin'
