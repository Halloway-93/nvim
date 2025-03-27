-- Lua
return {
	"folke/zen-mode.nvim",
	dependecies = {
		"folke/twilight.nvim",
	},
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		alacritty = {
			enabled = true,
			font = "16", -- font size
		},
	},
}
