local nugit = {
	ref_format = '"%(refname:short)»¦«%(authorname)»¦«%(committerdate)"',
	ref_tabulate = ' | lines | split column "»¦«" name author date',
	log_format = "%h»¦«%s»¦«%aN»¦«%aE»¦«%aD",
	log_tabulate = ' | lines | split column "»¦«" sha1 message author email date',
	upsert_date = " | upsert date ($in.date | into datetime)",
	update_message = ' | update message { str substring 0..25 | $in + "..." }',
	update_author = ' | update author { split words | if (length) < 2 { str join "" | str substring 0..1 } else { each { str substring 0..1 } | str join "" } }',
	update_name = ' | update name { if ($in | str length) < 25 { $in } else { str substring 0..25 | $in + "..." } }',
}

return {
	{
		"folke/snacks.nvim",
		opts = {
			-- Update dashboard logo
			dashboard = {
				preset = {
					header = [[

           ▄▀▄▀▀▀▀▄▀▄                  
           █        ▀▄      ▄          
          █  ▀  ▀     ▀▄▄  █ █         
          █ ▄ █▀ ▄       ▀▀  █         
          █  ▀▀▀▀            █         
          █                  █         
          █                  █         
           █  ▄▄  ▄▄▄▄  ▄▄  █          
           █ ▄▀█ ▄▀  █ ▄▀█ ▄▀          
            ▀   ▀     ▀   ▀            
          ]],
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{
						icon = " ",
						pane = 2,
						title = "Top Contributors",
						section = "terminal",
						enabled = vim.fn.isdirectory(".git") == 1,
						cmd = "nu -c 'git log --pretty="
							.. nugit.log_format
							.. nugit.log_tabulate
							.. "| histogram author merger | sort-by quantile | reject merger quantile | last 10 | reverse'",
						height = 14,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{
						icon = " ",
						pane = 2,
						title = "Recent Commits",
						section = "terminal",
						enabled = vim.fn.isdirectory(".git") == 1,
						cmd = "nu -c 'git log -n 10 --pretty="
							.. nugit.log_format
							.. nugit.log_tabulate
							.. "| each { $in"
							.. nugit.upsert_date
							.. nugit.update_message
							.. nugit.update_author
							.. "} | select message author date'",
						height = 14,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{
						icon = " ",
						pane = 2,
						title = "Local branches",
						section = "terminal",
						enabled = vim.fn.isdirectory(".git") == 1,
						cmd = "nu -c 'git branch --no-column --format="
							.. nugit.ref_format
							.. nugit.ref_tabulate
							.. "| first 10 | each { $in"
							.. nugit.upsert_date
							.. nugit.update_author
							.. nugit.update_name
							.. "}'",
						height = 14,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{ section = "startup" },
				},
			},
		},
	},

	-- Add more buffer controls
	{
		"akinsho/bufferline.nvim",
		keys = {
			{ "<leader>bL", "<Cmd>BufferLineMoveNext<CR>", "Move buffer backwards" },
			{ "<leader>bH", "<Cmd>BufferLineMovePrev<CR>", "Move buffer forwards" },
			{ "<leader>bs", "<Cmd>BufferLinePick<CR>", "Pick buffer to view" },
			{ "<leader>bS", "<Cmd>BufferLinePickClose<CR>", "Pick buffer to delete" },
		},
	},

	-- Zellij controls
	{
		"noahbald/nangz.nvim",
		keys = {
			{ "<leader>gg", "<cmd>Nangz lazygit<cr>", desc = "Lazygit" },
			{ "<leader><cr>", "<cmd>Nangz yazi<cr>", desc = "Explorer Yazi (Root dir)" },
			{ "<leader>E", "<cmd>Nangz yazi_cwd<cr>", desc = "Toggle Yazi (cwd)" },
			{ "<leader><space>", "<cmd>Nangz fzf_files<cr>", desc = "Find Files (Root dir)" },
			{ "<leader>/", "<cmd>Nangz fzf_grep<cr>", desc = "Grep (Root dir)" },
		},
	},
}
