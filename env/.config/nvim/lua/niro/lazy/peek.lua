return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
        vim.g.mkdp_auto_close = 1
        vim.g.mkdp_theme = "dark"
    end,
}
