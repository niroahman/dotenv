return {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
        local ss = require("smart-splits")
        -- navigate (tmux-aware via tmux.conf hook)
        vim.keymap.set("n", "<C-h>", ss.move_cursor_left)
        vim.keymap.set("n", "<C-j>", ss.move_cursor_down)
        vim.keymap.set("n", "<C-k>", ss.move_cursor_up)
        vim.keymap.set("n", "<C-l>", ss.move_cursor_right)
        -- resize with Alt+hjkl
        vim.keymap.set("n", "<A-h>", ss.resize_left)
        vim.keymap.set("n", "<A-j>", ss.resize_down)
        vim.keymap.set("n", "<A-k>", ss.resize_up)
        vim.keymap.set("n", "<A-l>", ss.resize_right)
        -- split
        vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
        vim.keymap.set("n", "<leader>ws", "<cmd>split<cr>", { desc = "Horizontal split" })
        vim.keymap.set("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close split" })
        -- swap buffers between splits
        vim.keymap.set("n", "<leader>wh", ss.swap_buf_left, { desc = "Swap split left" })
        vim.keymap.set("n", "<leader>wj", ss.swap_buf_down, { desc = "Swap split down" })
        vim.keymap.set("n", "<leader>wk", ss.swap_buf_up, { desc = "Swap split up" })
        vim.keymap.set("n", "<leader>wl", ss.swap_buf_right, { desc = "Swap split right" })
    end,
}
