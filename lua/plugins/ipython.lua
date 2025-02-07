return {
	-- vim-slime plugin for Python
	{
		"jpalardy/vim-slime",
		ft = "python", -- Load only for Python files
		config = function()
			-- Optional: configure vim-slime here
			vim.g.slime_target = "kitty" -- Example: set the target to tmux
			-- vim.b.slime_bracketed_paste = 1
			-- vim.g.slime_default_config = {session_id= "current", relative_pane= "right"}
			vim.g.slime_python_ipython = 1
			-- vim.g.slime_bracketed_paste = 1
		end,
	},
	-- vim-ipython-cell plugin for Python
	{
		"hanschen/vim-ipython-cell",
		ft = "python", -- Load only for Python files
		config = function()
			-- Optional: configure vim-ipython-cell here
			vim.g.ipython_cell_highlight_type = "IPython" -- Example: set the highlight type
		end,
	},

}
