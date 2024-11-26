return {
	-- Set lualine as statusline
	"nvim-lualine/lualine.nvim",
	-- See `:help lualine.txt`
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lazy.status")
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = "",
				section_separators = { left = "", right = "" },
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{
						"branch",
						icon = "", -- Another custom branch icon
						-- color = { bg = "002833", fg = "f86100" },
					},
					{
						"diff",
						-- colored = true,
						-- diff_color = {
						-- 	added = "LuaLineDiffAdd", -- Changes the diff's added color
						-- 	modified = "LuaLineDiffChange", -- Changes the diff's modified color
						-- 	removed = "LuaLineDiffDelete",
						-- },

						-- symbols = { added = " ", modified = "~", removed = " " },
						symbols = { added = "+ ", modified = "~ ", removed = "- " },
					},
					{
						"diagnostics",
						colored = true,
						-- diagnostics_color = {
						-- 	error = "LuaLineDiagnosticsError",
						-- 	warn = "LuaLineDiagnosticsWarn",
						-- 	hint = "LuaLineDiagnosticsHint",
						-- },
					},
				},
				lualine_c = {
					"filename",
				},
				lualine_x = {
					{ "encoding" },
					{ "fileformat", symbols = { unix = "", dos = "", mac = "" } },
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
		-- -- Define custom highlight groups for diff added, modified, and removed
		-- vim.api.nvim_command("highlight LuaLineDiffAdd guifg=#00d133 guibg=#003440")
		-- vim.api.nvim_command("highlight LuaLineDiffChange guifg=#c08f34 guibg=#003440")
		-- vim.api.nvim_command("highlight LuaLineDiffDelete guifg=#db312f guibg=#003440")
		-- -- custom highlight for diagnostics
		-- vim.api.nvim_command("highlight LuaLineDiagnosticsError guifg=#db312f guibg=#002833")
		-- vim.api.nvim_command("highlight LuaLineDiagnosticsWarn guifg=#c08f34 guibg=#002833")
		-- vim.api.nvim_command("highlight LuaLineDiagnosticsHint guifg=#2aa097 guibg=#002833")
	end,
}
