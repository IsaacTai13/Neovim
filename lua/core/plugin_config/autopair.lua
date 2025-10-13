local helper = require("core.helper")
local npairs = helper.safe_require("nvim-autopairs")
local Rule = helper.safe_require("nvim-autopairs.rule")

npairs.setup({})

vim.g.AutoPairsShortcutFastWrap = '<M-m>'
