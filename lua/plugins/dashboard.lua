return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		local db = require("dashboard")
		db.setup({
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{
						desc = " Obsidian",
						group = "Number",
						action = "ObsidianToday",
						key = "o",
					},
					{
						desc = " dotfiles",
						group = "Number",
						action = "TelescopeDotfiles",
						key = "d",
					},
				},
				footer={"Uderstanding is a moral duty."}
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
