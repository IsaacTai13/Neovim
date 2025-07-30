local helper = require("core.helper")
local catppuccin = helper.safe_require("catppuccin")

catppuccin.setup({
  background = { -- :h background
        light = "latte",
        dark = "mocha",
  },
})

vim.cmd.colorscheme 'catppuccin'
