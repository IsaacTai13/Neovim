local helper = require("core.helper")
local mason_tool_installer = helper.safe_require("mason-tool-installer")
local servers = require("core.lsp.servers")


-- Ensure the servers and tools above are installed
--
-- To check the current status of installed tools and/or manually install
-- other tools, you can run
--    :Mason
--
-- You can press `g?` for help in this menu.
--
-- `mason` had to be setup earlier: to configure its options see the
-- `dependencies` table for `nvim-lspconfig` above.
--
-- You can add other tools here that you want Mason to install
-- for you, so that they are available from within Neovim.
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	-- Formatters & linters (NOT LSP servers). These are invoked by conform.nvim,
	-- not started as language servers. See lua/core/plugin_config/conform.lua.
	'stylua',   -- Lua formatter
	'shfmt',    -- Shell/bash formatter
	'eslint_d', -- JS/TS linter + fixer
})

-- use mason_tool_installer to install all the tools at once including (lsp server, formatter and DAP)
mason_tool_installer.setup { ensure_installed = ensure_installed }