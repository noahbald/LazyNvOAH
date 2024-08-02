return {
	-- Update dap breakpoints to be persistent
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>db",
				"<cmd>PBToggleBreakpoint<cr>",
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dB",
				"<cmd>PBSetConditionalBreakpoint<cr>",
				desc = "Breakpoint Condition",
			},
			{
				"<leader>dx",
				"<cmd>PBClearAllBreakpoints<cr>",
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
