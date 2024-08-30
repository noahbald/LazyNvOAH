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
				{ "<leader>fq", "<cmd>Telescope grit query<cr>", desc = "Telescope Grit Query" },
				{ "<leader>fQ", "<cmd>Telescope grit list<cr>", desc = "Telescope Grit User Patterns" },
			},
		},
	},

	-- Remove neo-tree keybinds
	-- Prevent opening in no-neck-pain buffers
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
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.opt.relativenumber = true
						vim.opt.number = true
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

	-- Prettier markdown
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons", -- Used by the code blocks
		},
	},

	{
		"notomo/zebrazone.nvim",
		event = "BufEnter",
		dependencies = { "catppuccin/nvim" },
		config = function()
			local started = {}
			local start_buf = function(ev)
				local buf = vim.bo[ev.buf]
				local name = vim.api.nvim_buf_get_name(ev.buf)
				if name == "" then
					return
				end
				if not buf.buflisted then
					return
				end
				if vim.tbl_contains(started, ev.buf) then
					return
				end
				-- vim.notify(vim.inspect({ ev.buf, buf.buflisted, buf.buftype, name, vim.api.nvim_buf_is_loaded(ev.buf) }))
				table.insert(started, ev.buf)

				require("zebrazone").start({ bufnr = ev.buf })
			end
			vim.api.nvim_create_autocmd({ "BufEnter" }, {
				group = vim.api.nvim_create_augroup("zebrazone", { clear = true }),
				callback = start_buf,
			})
			start_buf({ buf = 0 })
		end,
	},

	-- git graph
	{
		"isakbm/gitgraph.nvim",
		---@type I.GGConfig
		opts = {
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			format = {
				timestamp = "%H:%M:%S %d-%m-%Y",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			hooks = {
				on_select_commit = function(commit)
					print("selected commit:", commit.hash)
				end,
				on_select_range_commit = function(from, to)
					print("selected range:", from.hash, to.hash)
				end,
			},
		},
		keys = {
			{
				"<leader>gl",
				function()
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end,
				desc = "GitGraph - Draw",
			},
		},
	},

	-- Better quick-fix (mainly for filtering)
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		dependencies = {
			"junegunn/fzf",
			setup = function()
				vim.fn["fzf#install"]()
			end,
		},
	},
}
