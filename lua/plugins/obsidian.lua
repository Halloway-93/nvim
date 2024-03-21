return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	--   "BufReadPre path/to/my-vault/**.md",
	--   "BufNewFile path/to/my-vault/**.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "Zettelkasten",
				path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettelkasten",
				overrides = {
					notes_subdir = "/Fleeting Notes",
				},
			},
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		-- notes_subdir = '/Fleeting Notes',
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "/Daily Journal",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%d-%m-%Y",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			alias_format = "%d-%m-%Y",
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = "Workday.md",
		},
		templates = {
			subdir = "/Templates",
		},
	},
}
