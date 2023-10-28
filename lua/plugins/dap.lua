return {
	-- Update bap breakpoints to be persistent
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>db",
				function()
					require("persistent-breakpoints.api").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("persistent-breakpoints.api").set_conditional_breakpoint()
				end,
				desc = "Breakpoint Condition",
			},
			{
				"<leader>dx",
				function()
					require("persistent-breakpoints.api").clear_all_breakpoints()
				end,
				desc = "Clear All Breakpoints",
			},
		},
		dependencies = {
			{
				"Weissle/persistent-breakpoints.nvim",
				opts = { load_breakpoints_event = { "BufReadPost" } },
			},
		},
	},
}
