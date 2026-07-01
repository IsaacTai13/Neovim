local helper = require("core.helper")
local mason_lspconfig = helper.safe_require("mason-lspconfig")
local capabilities = helper.safe_require('blink.cmp').get_lsp_capabilities()
local servers = require("core.lsp.servers")

mason_lspconfig.setup({
	ensure_installed = {}, -- explicitly set to an empty table (we already handled this via mason-tool-installer)

	-- nvim-lspconfig now ships an `lsp/stylua.lua` that runs `stylua --lsp`, and
	-- automatic_enable would start it because stylua is installed via mason. But
	-- stylua is a *formatter*, not an LSP server (our 2.1.0 has no --lsp), so it
	-- crashes with exit code 2. Exclude it (and other formatters) from auto-enable.
	automatic_enable = {
		exclude = { 'stylua' },
	},

	-- To only enable certain servers to be automatically enabled:
	-- automatic_enable = vim.tbl_keys(servers),
})

-- Neovim 0.11 introduces a new API `vim.lsp.config()` for declaratively registering LSP settings.
-- This replaces the old `lspconfig[server].setup()` and mason-lspconfig's setup_handlers.
-- Actual LSP activation is triggered by `vim.lsp.enable()` (which automatic_enable handles).
for server_name, config in pairs(servers) do
	-- print("Setting up LSP for:", server_name)
	config = config or {}
	config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})

	vim.lsp.config(server_name, config)
end