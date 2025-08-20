return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			-- Setup nvim-dap
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()

			-- Open the UI automatically when attaching
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)

			------------------------------------------------------------------
			-- VVVV  THIS IS THE BEST PLACE FOR YOUR STEPPING KEYMAPS VVVV  --
			------------------------------------------------------------------
			dap.listeners.after.event_initialized["dap_keymaps"] = function()
				print("💡 DAP session started. Setting buffer-local stepping keymaps.")

				-- Set keymaps for the current buffer only
				-- vim.keymap.set(mode, keys, action, options)
				vim.keymap.set("n", "<Down>", dap.step_over, { buffer = 0, silent = true, desc = "DAP: Step Over" })
				vim.keymap.set("n", "<Right>", dap.step_into, { buffer = 0, silent = true, desc = "DAP: Step Into" })
				vim.keymap.set("n", "<Left>", dap.step_out, { buffer = 0, silent = true, desc = "DAP: Step Out" })
				vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
				vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "DAP: Continue/Start" })
				vim.keymap.set(
					"n",
					"<Up>",
					dap.restart_frame,
					{ buffer = 0, silent = true, desc = "DAP: Restart Frame" }
				)
			end
		end,
	},
	{
		-- Extension of the nvim-dap providing setups for python.
		"mfussenegger/nvim-dap-python",
		ft = "python",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			-- Setup nvim-dap-python
			require("dap-python").setup("python")
			-- If using the above, then `python -m debugpy --version`
			-- must work in the shell
		end,
	},
}
