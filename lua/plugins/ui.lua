return {
	-- Turn off indent animations
	{
		"echasnovski/mini.indentscope",
		init = function()
			require("mini.indentscope").gen_animation.none()
		end,
	},

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
}
