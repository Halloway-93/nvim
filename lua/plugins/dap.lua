return {
	{
		-- UI for the debugger.
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			-- "theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			-- Setup nvim-dap
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()
			-- Setup nvim-dap-virtual-text
			-- require("nvim-dap-virtual-text").setup({})

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
			vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
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
