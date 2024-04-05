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

	{
		"nvim-treesitter/nvim-treesitter",
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treeitter** module to be loaded in time.
			-- Luckily, the only thins that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
			require("nvim-treesitter.install").compilers = { "zig", "gcc", "clang" }
		end,
	},
}
