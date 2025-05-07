return {
	-- Set lualine as statusline
	"nvim-lualine/lualine.nvim",
	-- See `:help lualine.txt`
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lazy.status")
		-- Define the word count function that handles selection
		local function getWords()
			local wc = vim.fn.wordcount()

			if wc["visual_words"] then
				-- If text is selected, show the count of selected words
				return "" .. tostring(wc["visual_words"])
			else
				-- Otherwise show total word count
				return "" .. tostring(wc["words"])
			end
		end

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
					{ getWords, icon = "󰈭" },
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
	end,
}
