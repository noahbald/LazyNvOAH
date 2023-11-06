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
}
