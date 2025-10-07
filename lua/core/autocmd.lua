-- Indent
local indent_augroup = vim.api.nvim_create_augroup("MyIndentRules", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = indent_augroup,
	pattern = { "python", "javascript", "typescript", "json", "yaml", "html", "css", "lua", "javascriptreact", "sh" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end
})

vim.api.nvim_create_autocmd("FileType", {
	group = indent_augroup,
	pattern = { "go" },
	callback = function()
	  vim.opt_local.tabstop = 4
	  vim.opt_local.shiftwidth = 4
	  vim.opt_local.expandtab = false
	end,
})

-- Automatically create missing parent directories before saving a file
-- This ensures that when you try to write a file in a non-existent folder (e.g., :e models/user.js),
-- the directory will be created automatically to prevent save errors like "E212: Can't open file for writing"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Get the absolute directory path of the current file being saved
    local dir = vim.fn.expand("<afile>:p:h")

    -- If the directory doesn't exist, create it (with -p flag to make parent folders as needed)
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})
