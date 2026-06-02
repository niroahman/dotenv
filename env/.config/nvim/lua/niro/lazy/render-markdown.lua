return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown", "mdx" },
    opts = {
        file_types = { "markdown", "mdx" },
        code = {
            enabled = true,
            style = "full",  -- background highlight for code blocks
        },
        heading = {
            enabled = true,
            signs = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
        },
        bullet = { enabled = true },
        checkbox = { enabled = true },
        link = { enabled = true },
        html = { enabled = false },
        latex = { enabled = false },
        yaml = { enabled = false },
    },
}
