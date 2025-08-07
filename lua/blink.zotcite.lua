-- Blink.cmp compatible zotcite source

local M = {}

-- Configuration options
local options = {
	filetypes = { "markdown", "rmd", "quarto", "typst", "vimwiki" },
}

-- Lazy load zotcite modules
local zc = nil
local function get_zotcite_config()
	if not zc then
		local ok, module = pcall(require, "zotcite.config")
		if not ok then
			return nil
		end
		zc = module
	end
	return zc
end

-- Setup function for configuration
M.setup = function(opts)
	options = vim.tbl_extend("force", options, opts or {})
end

-- Check if the source is available for current filetype
local function is_available()
	for _, v in pairs(options.filetypes) do
		if vim.bo.filetype == v then
			return true
		end
	end
	return false
end

-- Check if we're in valid markdown context (not in code blocks, etc.)
local function is_valid_context(context)
	local lines = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, true)
	local lnum = vim.fn.line(".")

	for i = lnum, 1, -1 do
		if string.find(lines[i], "^```{") then
			return false -- within code block
		elseif string.find(lines[i], "^```$") then
			break -- after a code block
		elseif (string.find(lines[i], "^---$") or string.find(lines[i], "^%.%.%.$")) and i > 1 then
			break -- after YAML front matter
		elseif string.find(lines[i], "^---$") and i == 1 then
			return false -- within YAML front matter
		end
	end

	return true
end

-- Main completion function for blink.cmp
M.get_completions = function(context, callback)
	-- Check if zotcite is available
	local zotcite_config = get_zotcite_config()
	if not zotcite_config then
		return callback({ items = {} })
	end

	-- Check if source is available and context is valid
	if not is_available() or not is_valid_context(context) then
		return callback({ items = {} })
	end

	-- Check if we have @ trigger
	local line_before_cursor = context.line:sub(1, context.cursor[2])
	local trigger_offset = line_before_cursor:find("@[^%s]*$")

	if not trigger_offset then
		return callback({ items = {} })
	end

	local input = line_before_cursor:sub(trigger_offset + 1) -- Remove @ symbol

	-- Initialize zotcite if needed
	if not zotcite_config.inited() then
		zotcite_config.init()
	end

	-- Get full file path
	local fullfname = vim.fn.expand("%:p")
	if vim.fn.has("win32") == 1 then
		fullfname = string.gsub(tostring(fullfname), "\\", "/")
	end

	-- Get matching Zotero keys
	local itms = vim.fn.py3eval('ZotCite.GetMatch("' .. input .. '", "' .. fullfname .. '")')

	local items = {}
	if itms then
		for _, v in pairs(itms) do
			local txt = v[2] .. " " .. v[3]
			if vim.fn.strwidth(txt) > 58 then
				txt = vim.fn.strcharpart(txt, 0, 58) .. "⋯"
			end

			table.insert(items, {
				label = txt,
				kind = require("blink.cmp").lsp.CompletionItemKind.Reference,
				insertText = v[1],
				-- For blink.cmp, we need to specify the range to replace
				textEdit = {
					newText = v[1],
					range = {
						start = { line = context.cursor[1] - 1, character = trigger_offset - 1 },
						["end"] = { line = context.cursor[1] - 1, character = context.cursor[2] },
					},
				},
				-- Store zotero key for documentation lookup
				data = { zkey = v[1] },
			})
		end
	end

	callback({ items = items })
end

-- Resolve function for additional documentation
M.resolve = function(item, callback)
	if item.data and item.data.zkey then
		-- Try to get zotcite.hl module
		local ok, hl_module = pcall(require, "zotcite.hl")
		if ok then
			vim.schedule(function()
				hl_module.citations()
			end)
		end

		local zkey = string.gsub(item.data.zkey, "%-.*", "")
		local ref = vim.fn.py3eval('ZotCite.GetRefData("' .. zkey .. '")')

		if ref then
			local doc = ""
			local ttl = " "
			if ref.title then
				ttl = ref.title
			end
			local etype = string.gsub(ref.etype, "([A-Z])", " %1")
			etype = string.lower(etype)
			doc = etype .. "\n\n**" .. ttl .. "**\n\n"

			if ref.etype == "journalArticle" and ref.publicationTitle then
				doc = doc .. "*" .. ref.publicationTitle .. "*\n\n"
			elseif ref.etype == "bookSection" and ref.bookTitle then
				doc = doc .. "In *" .. ref.bookTitle .. "*\n\n"
			end

			if ref.alastnm then
				doc = doc .. ref.alastnm
			end
			if ref.year then
				doc = doc .. " (" .. ref.year .. ") "
			else
				doc = doc .. " (????) "
			end

			item.documentation = {
				kind = "markdown",
				value = doc,
			}
		end
	end

	callback(item)
end

-- Execute function (called after completion is accepted)
M.execute = function(item, callback)
	local ok, config_module = pcall(require, "zotcite.config")
	if ok then
		vim.schedule(function()
			config_module.hl_citations()
		end)
	end
	callback(item)
end

return M
