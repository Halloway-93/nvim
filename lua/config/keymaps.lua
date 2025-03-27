-- keymaps.lua
-- Navigate between split windows with Cmd+h, j, k, l
local map = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local dap = require("dap")
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
keymap("n", "<leader>t", ":Floaterminal<CR>", opts)

-- Send the section of code to the terminal
map("n", "<leader>sc", ":IPythonCellExecuteCell<CR>", opts)

--Send the line of code to the terminal
map("n", "<leader>sa", ":IPythonCellExecuteCellJump<CR>", opts)

--Send the all code  up to the cell to the terminal
map("n", "<leader>cb", ":IPythonCellInsertBelow<CR>", opts)

--gitlazy keymap
map("n", "<Leader>gg", [[:LazyGit<CR>]], opts)

--telescope
-- See `:help telescope.builtin`
keymap("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
keymap("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
keymap(
	"n",
	"<leader>/",
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find,
	{ desc = "[/] Fuzzily search in current buffer" }
	-- keymap("n", "<leader>e", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
)
keymap("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
keymap("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
keymap("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
keymap("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
keymap("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
keymap("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
keymap("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap("n", "<leader>do", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
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

-- Keymaps for debugger:
keymap("n", "<leader>dc", function()
	dap.continue()
end)
keymap("n", "<F10>", function()
	dap.step_over()
end)
keymap("n", "<F11>", function()
	dap.step_into()
end)
keymap("n", "<F12>", function()
	dap.step_out()
end)
keymap("n", "<Leader>b", function()
	dap.toggle_breakpoint()
end)
keymap("n", "<Leader>B", function()
	dap.set_breakpoint()
end)

--Entering in writer mode
keymap("n", "<leader>p", [[:Pencil|ZenMode<CR>]])
-- Pandoc md to pdf
vim.keymap.set("n", "<leader>pdf", function()
	local current_file = vim.fn.shellescape(vim.fn.expand("%"))
	local output_file = vim.fn.shellescape(vim.fn.expand("%:r") .. ".pdf")
	local zotref_path = vim.fn.shellescape(vim.fn.expand("~/.local/share/nvim/lazy/zotcite/python3/zotref.py"))
	local csl_path = vim.fn.shellescape(vim.fn.expand("~/Zotero/styles/ieee.csl"))
	local cmd = string.format(
		"!pandoc %s -s -o %s --filter pandoc-crossref -F %s --citeproc --csl=%s",
		current_file,
		output_file,
		zotref_path,
		csl_path
	)
	vim.cmd(cmd)
end, { desc = "Convert markdown to PDF with pandoc+zotero+crossref" }) -- Pandoc Markdown to PDF conversion with Zotero citations
