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
}
