return {
	-- Color picker and converter
	{
		"uga-rosa/ccc.nvim",
		opts = {
			highlighter = {
				auto_enable = true,
				lsp = true,
			},
		},
		keys = {
			{ "<leader>cc", "<cmd> CccConvert <cr>", desc = "Covert color" },
			{ "<leader>cp", "<cmd> CccPick <cr>", desc = "Open color picker" },
		},
		event = "LspAttach",
	},

	-- Add telescope fzf native
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},

	-- Remove neo-tree keybinds
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{ "<leader>e", false },
			{ "<leader>E", false },
		},
	},

	-- Prevent flash from escaping search
	{
		"folke/flash.nvim",
		opts = {
			modes = {
				search = {
					enabled = false,
				},
			},
		},
	},

	-- Center float buffer
	{
		"shortcuts/no-neck-pain.nvim",
		opts = {
			width = 120,
			autocmds = {
				enableOnVimEnter = true,
				skipEnteringNoNeckPainBuffer = true,
			},
			buffers = {
				colors = {
					background = "#181825",
				},
			},
		},
	},
}
