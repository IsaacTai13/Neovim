-- Indent
local indent_augroup = vim.api.nvim_create_augroup("MyIndentRules", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = indent_augroup,
	pattern = { "python", "javascript", "typescript", "json", "yaml", "html", "css", "lua", "javascriptreact" },
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
