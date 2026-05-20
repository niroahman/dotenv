return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        return {
            lsp = {
                code_actions = {
                    previewer = "codeaction_native",
                    preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
                },
            },
        }
    end,
    keys = {
        {
            "<leader>ca",
            function() require("fzf-lua").lsp_code_actions() end,
            desc = "Code Actions (fzf)",
        },
    },
}
