-- keymaps.lua
-- Navigate between split windows with Cmd+h, j, k, l
local map = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
map("i", "jk", "<ESC>", opts)
map("t", "<Esc><Esc>", "<C-\\><C-n>", opts)
-- Keymaps for moving between windows
map("n", "<M-h>", "<C-w>h", opts)
map("n", "<M-j>", "<C-w>j", opts)
map("n", "<M-k>", "<C-w>k", opts)
map("n", "<M-l>", "<C-w>l", opts)
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Generals Keymaps

-- Increase/decrease window width
keymap("n", "<S-h>", ":vertical resize +5<CR>", opts)
keymap("n", "<S-l>", ":vertical resize -5<CR>", opts)

-- Increase/decrease window height
keymap("n", "<S-k>", ":resize +5<CR>", opts)
keymap("n", "<S-j>", ":resize -5<CR>", opts)

-- Move block text up and down
keymap("v", "<S-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<S-k>", ":m '<-2<CR>gv=gv", opts)

--Keymaps for nvim tree
-- keymap("n", "<leader>t", ":Floaterminal<CR>", opts)

-- Send the section of code to the terminal
-- map("n", "<leader>sc", ":IPythonCellExecuteCell<CR>", opts)

--Send the line of code to the terminal
map("n", "<leader>sa", ":IPythonCellExecuteCellJump<CR>", opts)

--Send the all code  up to the cell to the terminal
map("n", "<leader>cb", ":IPythonCellInsertBelow<CR>", opts)

-- Diagnostic keymaps
-- Key mapping to trigger the Format command
map("x", "<leader>p", '"_dP', opts)
-- map("n", "<Leader>f", [[:Format<CR>]], opts)
--keep the cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", {})
keymap("n", "<C-u>", "<C-u>zz", {})
-- keep the cursor centered when searching
keymap("n", "n", "nzzzv", {})
keymap("n", "N", "Nzzzv", {})

-- Keymaps for Obsidian:
keymap("n", "<leader>nn", [[:ObsidianNew<CR>]])
keymap("n", "<leader>ot", [[:ObsidianTemplate<CR>]])
keymap("n", "<leader>gn", [[:ObsidianQuickSwitch<CR>]], { desc = "[G]rep [N]otes" })

--Entering in writer mode
-- keymap("n", "<leader>p", [[:Pencil|ZenMode<CR>]])
-- Pandoc md to pdf
vim.keymap.set("n", "<leader>pdf", function()
	local current_file = vim.fn.expand("%")
	local output_file = vim.fn.expand("%:r") .. ".pdf"
	local csl_path = vim.fn.expand("~/Zotero/styles/pnas.csl")

	local cmd = {
		"pandoc",
		current_file,
		"-s",
		"-o",
		output_file,
		"--filter",
		"pandoc-crossref",
		"--citeproc",
		"--csl=" .. csl_path,
	}

	vim.fn.jobstart(cmd, {
		env = {
			PATH = "/usr/local/texlive/2026basic/bin/universal-darwin:" .. vim.env.PATH,
			HOME = vim.env.HOME,
		},
		stderr_buffered = true,
		on_stderr = function(_, data)
			if data then
				vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
			end
		end,
		on_exit = function(_, code)
			if code == 0 then
				vim.notify("PDF built successfully", vim.log.levels.INFO)
			else
				vim.notify("Pandoc failed with code " .. code, vim.log.levels.ERROR)
			end
		end,
	})
end, { desc = "Convert markdown to PDF" })
