return {
	-- Catppuccin theme
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		opts = {
			custom_highlights = function()
				return {
					ZebrazoneDefault = { bg = "#242434" },
				}
			end,
			integrations = { blink_cmp = true },
		},
	},

	-- Set color theme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},
}
