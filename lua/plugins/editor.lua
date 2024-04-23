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

	-- Telecope file history
	{
		"telescope.nvim",
		dependencies = {
			"isak102/telescope-git-file-history.nvim",
			dependencies = { "tpope/vim-fugitive" },
			keys = {
				{ "<leader>gF", "<cmd>Telescope git_file_history<cr>", desc = "Telescope Current File History" },
			},
		},
	},

	-- Telescope grit
	{
		"telescope.nvim",
		dependencies = {
			"noahbald/grit-telescope.nvim",
			keys = {
				{ "<leader>fq", "<cmd>Telescope grit<cr>", desc = "Telescope Grit Query" },
			},
		},
	},

	-- Remove neo-tree keybinds
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
			open_files_do_not_replace_types = { "no-neck-pain" },
		},
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
