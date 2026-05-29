-- nvim-treesitter-textobjects `main` branch — required for Neovim 0.12+.
return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
                selection_modes = {
                    ["@parameter.outer"] = "v",
                    ["@function.outer"] = "V",
                    ["@class.outer"] = "<c-v>",
                },
                include_surrounding_whitespace = true,
            },
            swap = {},
        })

        local select_to = require("nvim-treesitter-textobjects.select")
        local swap = require("nvim-treesitter-textobjects.swap")

        local function map_select(lhs, query, group, desc)
            vim.keymap.set({ "x", "o" }, lhs, function()
                select_to.select_textobject(query, group or "textobjects")
            end, { desc = desc })
        end

        map_select("af", "@function.outer", nil, "Select outer function")
        map_select("if", "@function.inner", nil, "Select inner function")
        map_select("ak", "@class.outer", nil, "Select outer class")
        map_select("ic", "@class.inner", nil, "Select inner class")
        map_select("ac", "@comment.outer", nil, "Select outer comment")
        map_select("ao", "@comment.outer", nil, "Select outer comment")
        map_select("as", "@local.scope", "locals", "Select language scope")

        vim.keymap.set("n", "<leader>a", function()
            swap.swap_next("@parameter.inner")
        end, { desc = "Swap with next parameter" })

        vim.keymap.set("n", "<leader>A", function()
            swap.swap_previous("@parameter.inner")
        end, { desc = "Swap with previous parameter" })
    end,
}
