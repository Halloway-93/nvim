return{
    "iamcco/markdown-preview.nvim",
	dependencies={"nvim-lua/plenary.nvim"},
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
}

