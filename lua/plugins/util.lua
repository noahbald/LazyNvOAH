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

	-- Zellij shortcuts
	{
		"nvim-lua/plenary.nvim",
		keys = {
			{
				"<leader>gg",
				function()
					require("plenary.job")
						:new({
							command = "zellij",
							args = {
								"r",
								"-i",
								"-c",
								"--",
								"lazygit",
							},
							on_stderr = function(e)
								vim.notify("failed to launch lazygit\n" .. e)
							end,
						})
						:start()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>uy",
				function()
					require("plenary.job")
						:new({
							command = "zellij",
							args = {
								"r",
								"-f",
								"-c",
								"--",
								"yazi",
								vim.uv.cwd(),
							},
							on_stderr = function(e)
								vim.notify("failed to launch yazi\n" .. e)
							end,
						})
						:start()
				end,
				desc = "Toggle Yazi",
			},
		},
	},
}
