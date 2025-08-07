-- return {
-- 	-- Autocompletion
-- 	"hrsh7th/nvim-cmp",
-- 	dependencies = {
-- 		"jmbuhr/cmp-pandoc-references", -- Snippet Engine & its associated nvim-cmp source
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
-- 				{ name = "pandoc_references" },
-- 				{ name = "cmp_zotcite" },
-- 			},
-- 			experimental = {
-- 				ghost_text = true,
-- 			},
-- 		})
-- 	end
return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		-- Add zotcite dependency
		{
			"jalvesaq/zotcite",
			ft = { "markdown", "rmd", "quarto", "typst", "vimwiki" },
		},
	},
	-- use a release tag to download pre-built binaries
	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		keymap = { preset = "default" },
		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
		-- Show documentation popup automatically
		completion = { documentation = { auto_show = true } },
		-- Default list of enabled providers
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "zotcite" },
			providers = {
				zotcite = {
					name = "zotcite",
					module = "blink_zotcite",
					score_offset = 1000, -- High priority for citations
					opts = {
						filetypes = { "markdown", "rmd", "quarto", "typst", "vimwiki" },
					},
				},
			},
		},
		-- Rust fuzzy matcher for better performance
		fuzzy = { implementation = "prefer_rust" },
	},
	opts_extend = { "sources.default" },
}
