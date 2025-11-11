local helper = require("core.helper")
local treesitter = helper.safe_require("nvim-treesitter")

-- Tell Treesitter to use the 'tsx' parser for files with filetype 'javascriptreact'
vim.treesitter.language.register("tsx", "javascriptreact")

treesitter.setup ({
  ensure_installed = {
    "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc", "javascript", "typescript", "dockerfile", "yaml", "json", "tsx", "css", "terraform"
  },
  highlight = {
    enable = true,
  },
})


-- Because there is a bug, for "javascriptreact" filetype, treesitter doesn't auto
-- enable syntax highlight. So I'll have to enable manually.
-- Automatically attach Treesitter's highlight module to 'javascriptreact' files
-- This ensures that syntax highlighting works properly for JSX in .jsx files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascriptreact",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    -- Manually attach the 'tsx' parser's highlighting to the current buffer
    require("nvim-treesitter.highlight").attach(bufnr, "tsx")
  end,
})
