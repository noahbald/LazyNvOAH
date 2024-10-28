return {
	-- Update dashboard logo
	{
		"nvimdev/dashboard-nvim",
		opts = function(_, dashboard)
			local logo = [[

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
            ]]
			dashboard.config.header = vim.split(logo, "\n")
			table.remove(dashboard.config.center, 8)
			table.remove(dashboard.config.center, 8)
			return dashboard
		end,
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
}
