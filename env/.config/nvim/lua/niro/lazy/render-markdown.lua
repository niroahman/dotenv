return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
        "3rd/image.nvim",
    },
    ft = { "markdown", "mdx" },
    opts = {
        file_types = { "markdown", "mdx" },
        code = {
            enabled = true,
            style = "full",
        },
        heading = {
            enabled = true,
            signs = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
        },
        bullet = { enabled = true },
        checkbox = { enabled = true },
        link = { enabled = true },
        html = { enabled = true },
        latex = { enabled = false },
        yaml = { enabled = false },
        image = { enabled = true },
    },
}
