return {
    "wuelnerdotexe/vim-astro",
    ft = { "astro" },
    init = function()
        vim.filetype.add({ extension = { astro = "astro" } })
        -- prevent vim-astro from overriding treesitter highlighting
        vim.g.astro_typescript = "enable"
        vim.g.astro_stylus = "disable"
    end,
}
