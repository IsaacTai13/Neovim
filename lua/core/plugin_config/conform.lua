local helper = require("core.helper")
local conform = helper.safe_require("conform")

if not conform then return end

conform.setup({
  notify_on_error = true,

  -- Map filetype -> formatter(s). The tool itself is installed via mason
  -- (see lua/core/lsp/mason-tool-installer.lua). conform only knows how to
  -- *call* it when you save / press <leader>cf.
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    -- eslint_d --fix for JS/TS. Only runs when the project actually has an
    -- eslint config; otherwise conform skips it quietly.
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
  },

  -- Format automatically on save. Returning nil (via the guard) disables it.
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    -- lsp_format = "fallback": if no formatter is configured for this filetype,
    -- fall back to the LSP server's own formatting (if it supports it).
    return { timeout_ms = 1000, lsp_format = "fallback" }
  end,
})

-- Toggle autoformat-on-save.
--   :FormatDisable   -> turn off for all buffers
--   :FormatDisable!  -> turn off for the current buffer only
--   :FormatEnable    -> turn it back on
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat-on-save" })
