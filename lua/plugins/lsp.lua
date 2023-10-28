return {
	-- TypeScript LSP made more performant by using native TS Server (like VSCode)
	{
		"pmizio/typescript-tools.nvim",
		opts = {
			settings = {
				expose_as_code_action = "all",
				tsserver_plugins = {
					"@styled/typescript-styled-plugin",
				},
				-- Prevent file table overflow. FYI this is double the memory that VSCode allows
				tsserver_max_memory = "8192",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"neovim/nvim-lspconfig",
				opts = {
					---@type lspconfig.options
					servers = {
						tsserver = {
							enabled = false,
						},
					},
				},
			},
		},
		build = "npm i -g @styled/typescript-styled-plugin",
		event = "LspAttach",
	},

	-- Convert strings to template strings when `${}` syntax is used
	{
		"axelvc/template-string.nvim",
		event = "LspAttach",
	},
}
