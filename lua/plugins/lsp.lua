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
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "npm i -g @styled/typescript-styled-plugin",
		event = "LazyFile",
	},

	-- Convert strings to template strings when `${}` syntax is used
	{
		"axelvc/template-string.nvim",
		event = "LspAttach",
	},

	-- Add folding range capabilities
	{
		"neovim/nvim-lspconfig",
		opts = {
			---@type lspconfig.options
			servers = {
				biome = {},
			},
			capabilities = {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			},
		},
	},

	-- add nvim-ufo
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			"luukvbaal/statuscol.nvim",
		},
		event = "BufReadPost",
		opts = function()
			return require("config.ufo")
		end,

		init = function()
			-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
			vim.keymap.set("n", "zR", function()
				require("ufo").openAllFolds()
			end)
			vim.keymap.set("n", "zM", function()
				require("ufo").closeAllFolds()
			end)
		end,
	},
}
