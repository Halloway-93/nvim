-- lazy.nvim
return {
	"folke/snacks.nvim",
	priority = 1000,
	---@type snacks.Config
	opts = {
		dim = {},
	},
	config = function(_, opts)
		require("snacks").setup(opts)
		-- If you want to enable dimming
		require("snacks.dim").enable(opts.dim)
	end,
}
