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

	{
		"NvChad/nvim-colorizer.lua",
		event = "LazyFile",
		opts = {
			user_default_options = {
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				AARRGGBB = true, -- 0xAARRGGBB hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				tailwind = true,
			},
		},
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
