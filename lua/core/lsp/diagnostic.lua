-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = '󰅚 ',
			[vim.diagnostic.severity.WARN] = '󰀪 ',
			[vim.diagnostic.severity.INFO] = '󰋽 ',
			[vim.diagnostic.severity.HINT] = '󰌶 ',
		},
	} or {},
	virtual_text = {
		source = 'if_many',
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = "E: " .. diagnostic.message,
				[vim.diagnostic.severity.WARN] = "W: " .. diagnostic.message,
				[vim.diagnostic.severity.INFO] = "I: " .. diagnostic.message,
				[vim.diagnostic.severity.HINT] = "H: " .. diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
}

-- Show detailed diagnostic message in a floating window.
-- Use this when an error message is too long or gets truncated.
-- Example: press <leader>d to open a popup with the full warning or error.
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = '[L]SP [D]iagnostic details' })
