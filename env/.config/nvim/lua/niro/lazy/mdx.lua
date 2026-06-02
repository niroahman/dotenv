return {
    "davidmh/mdx.nvim",
    ft = { "mdx" },
    init = function()
        -- Must register filetype BEFORE lazy loads the plugin,
        -- otherwise .mdx files never trigger ft="mdx" and the plugin never loads.
        vim.filetype.add({ extension = { mdx = "mdx" } })
    end,
    config = true,
}
