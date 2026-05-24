return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",

		-- Useful status updates for LSP
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

		-- Additional lua configuration, makes nvim stuff amazing!
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					{ plugins = { "nvim-dap-ui" }, types = true },
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		-- [[ Configure LSP ]]
		-- This function gets run when an LSP connects to a particular buffer.
		local on_attach = function(_, bufnr)
			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_fallback = true, range = range })
			end, { range = true })
		end

		-- Auto-format on save (moved outside on_attach to avoid duplicates)
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf, lsp_fallback = true })
			end,
		})

		-- Mason setup - must be called before setting up servers
		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"ruff",
				"pyright",
				"debugpy",
				"stylua",
				"luacheck",
				"shellcheck",
				"prettierd",
			},
		})

		-- Define your servers
		local servers = {
			pyright = {},
			ruff = { filetypes = { "python" } },
			nil_ls = {},
			lua_ls = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		}

		-- Get blink.cmp capabilities for LSP
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Setup mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = {
				"pyright",
				"ruff",
				"lua_ls",
				"nil_ls",
			},
		})

		-- Setup each server with blink.cmp capabilities
		for server_name, server_settings in pairs(servers) do
			vim.lsp.config(server_name, {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = server_settings,
				filetypes = (server_settings or {}).filetypes,
			})
		end
	end,
}
