local conform_condition_memo = {}

local M = {
	has_biome_config = function(ctx)
		return vim.fs.find(
			{ "biome.json", "biome.jsonc" },
			{ path = ctx.filename, upwards = true, stop = vim.uv.cwd(), type = "file" }
		)[1]
	end,
}
M.has_biome_config = LazyVim.memoize(M.has_biome_config)

return {
	-- Ensure formatters are installed
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			table.insert(opts.ensure_installed, "biome")
			table.insert(opts.ensure_installed, "prettierd")
			table.insert(opts.ensure_installed, "prettier")
		end,
	},

	-- Ensure formatters are included in language server
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = opts.sources or {}
			table.insert(opts.sources, nls.builtins.formatting.biome)
			table.insert(opts.sources, nls.builtins.formatting.prettierd)
			table.insert(opts.sources, nls.builtins.formatting.prettier)
		end,
	},

	-- Force order of precedence for formatters, in order of performance
	-- Filter by project/filetype
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters = {
				biome = {
					condition = M.has_biome_config,
				},
			},
			formatters_by_ft = {
				["javascript"] = { { "biome", "prettierd", "prettier" } },
				["javascriptreact"] = { { "biome", "prettierd", "prettier" } },
				["typescript"] = { { "biome", "prettierd", "prettier" } },
				["typescriptreact"] = { { "biome", "prettierd", "prettier" } },
				["vue"] = { { "biome", "prettierd", "prettier" } },
				["css"] = { { "prettierd", "prettier" } },
				["scss"] = { { "prettierd", "prettier" } },
				["less"] = { { "prettierd", "prettier" } },
				["html"] = { { "prettierd", "prettier" } },
				["json"] = { { "biome", "prettierd", "prettier" } },
				["jsonc"] = { { "biome", "prettierd", "prettier" } },
				["yaml"] = { { "prettierd", "prettier" } },
				["markdown"] = { { "prettierd", "prettier" } },
				["markdown.mdx"] = { { "prettierd", "prettier" } },
				["graphql"] = { { "prettierd", "prettier" } },
				["handlebars"] = { { "prettierd", "prettier" } },
			},
		},
	},
}
