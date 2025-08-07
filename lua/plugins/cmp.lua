-- return {
-- 	-- Autocompletion
-- 	"hrsh7th/nvim-cmp",
-- 	dependencies = {
-- 		-- "jmbuhr/cmp-pandoc-references", -- Snippet Engine & its associated nvim-cmp source
-- 		"L3MON4D3/LuaSnip",
-- 		"saadparwaiz1/cmp_luasnip",
-- 		"hrsh7th/cmp-path",
-- 		"hrsh7th/cmp-buffer",
-- 		-- Adds a number of user-friendly snippets
-- 		"rafamadriz/friendly-snippets",
-- 	},
-- 	config = function()
-- 		local cmp = require("cmp")
-- 		local luasnip = require("luasnip")
-- 		-- Don't know if I should keep this code here
-- 		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
--
-- 		require("luasnip.loaders.from_vscode").lazy_load()
-- 		cmp.setup({
-- 			completion = {
-- 				completopt = "menu,menuone,noinsert",
-- 			},
-- 			snippet = {
-- 				expand = function(args)
-- 					luasnip.lsp_expand(args.body)
-- 				end,
-- 			},
-- 			mapping = cmp.mapping.preset.insert({
-- 				["<C-n>"] = cmp.mapping.select_next_item(),
-- 				["<C-p>"] = cmp.mapping.select_prev_item(),
-- 				["<C-d>"] = cmp.mapping.scroll_docs(-4),
-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 				["<C-Space>"] = cmp.mapping.complete({}),
-- 				["<CR>"] = cmp.mapping.confirm({
-- 					behavior = cmp.ConfirmBehavior.Replace,
-- 					select = true,
-- 				}),
-- 				["<Tab>"] = cmp.mapping(function(fallback)
-- 					if cmp.visible() then
-- 						cmp.select_next_item()
-- 					elseif luasnip.expand_or_locally_jumpable() then
-- 						luasnip.expand_or_jump()
-- 					else
-- 						fallback()
-- 					end
-- 				end, { "i", "s" }),
-- 				["<S-Tab>"] = cmp.mapping(function(fallback)
-- 					if cmp.visible() then
-- 						cmp.select_prev_item()
-- 					elseif luasnip.locally_jumpable(-1) then
-- 						luasnip.jump(-1)
-- 					else
-- 						fallback()
-- 					end
-- 				end, { "i", "s" }),
-- 			}),
-- 			sources = {
-- 				-- { name = "copilot", group_index = 2 },
-- 				-- Other Sources
-- 				{ name = "nvim_lsp" },
-- 				{ name = "luasnip" },
-- 				{ name = "buffer" },
-- 				{ name = "path" },
-- 				-- { name = "pandoc_references" },
-- 				{ name = "cmp_zotcite" },
-- 			},
-- 			experimental = {
-- 				ghost_text = true,
-- 			},
-- 		})
-- 	end
-- }
return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	-- use a release tag to download pre-built binaries
	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	-- In your cmp.lua file, for "saghen/blink.cmp"
	-- In your cmp.lua file, for "saghen/blink.cmp"
	-- TEMPORARY DEBUGGING CONFIGURATION
	opts = {
		keymap = { 
			preset = "default",
			-- Try different keymap syntax for Ctrl+Y
			['<C-y>'] = { 'accept' },
			-- Also add Tab as accept for testing
			['<Tab>'] = { 'accept', 'fallback' },
		},
		appearance = { nerd_font_variant = "mono" },
		completion = { 
			documentation = { auto_show = true },
			accept = {
				-- Make sure auto-brackets don't interfere
				auto_brackets = { enabled = false },
			},
		},
		fuzzy = { implementation = "prefer_rust" },
		-- ==========================================================
		-- FINAL, CORRECTED SOURCES CONFIGURATION
		-- ==========================================================
		sources = {
			-- Restore your other default sources
			default = { "lsp", "path", "snippets", "buffer", "zotcite" },
			-- The 'providers' table defines the details for custom sources
			providers = {
				zotcite = {
					name = "zotcite",
					module = "blink_zotcite", -- Points to our bridge file
					score_offset = 1000, -- High priority for citations
					-- The 'opts' table is the correct place for custom data.
					-- This table will be passed to our source's 'new()' function.
					opts = {
						filetypes = { "pandoc", "markdown", "rmd", "quarto" },
					},
				},
			},
		},
		-- Do not use opts_extend for this to keep it clear and simple
	},
	opts_extend = { "sources.default" },
}--
