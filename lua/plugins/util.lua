return {
	-- Load previous session automatically
	{
		"folke/persistence.nvim",
		init = function()
			if vim.fn.argc() ~= 0 then
				require("persistence").stop()
				return
			end
			require("persistence").load()
		end,
		dependencies = { "folke/snacks.nvim" },
	},

	-- Profiling
	{
		"stevearc/profile.nvim",
		-- WARN: disabled
		enabled = false,
		keys = {
			{
				"<f2>",
				function()
					local prof = require("profile")
					if prof.is_recording() then
						prof.stop()
						vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
							if filename then
								prof.export(filename)
								vim.notify(string.format("Wrote %s", filename))
							end
						end)
					else
						prof.start("*")
					end
				end,
			},
		},
	},
}
