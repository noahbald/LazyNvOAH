-- local should_profile = os.getenv("NVIM_PROFILE")
-- if should_profile then
-- 	require("profile").instrument_autocmds()
-- 	if should_profile:lower():match("^start") then
-- 		require("profile").start("*")
-- 	else
-- 		require("profile").instrument("*")
-- 	end
-- end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("nvim-treesitter.install").prefer_git = true
