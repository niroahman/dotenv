return {
	"tpope/vim-fugitive",
	cmd = { "G", "Git", "Gvdiffsplit", "Gdiffsplit", "Gread", "Gwrite" },
	keys = {
		{ "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
		{ "<leader>gf", "<cmd>tab Gvdiffsplit!<cr>", desc = "Git 3-way diff" },
	},
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			callback = function() end,
		})
		-- diffget binds only in diff mode
		vim.api.nvim_create_autocmd("OptionSet", {
			pattern = "diff",
			callback = function()
				if vim.o.diff then
					vim.keymap.set("n", "tl", ":diffget //2<cr>", { buffer = true, desc = "Take left (ours)" })
					vim.keymap.set("n", "tr", ":diffget //3<cr>", { buffer = true, desc = "Take right (theirs)" })
				end
			end,
		})
	end,
}
