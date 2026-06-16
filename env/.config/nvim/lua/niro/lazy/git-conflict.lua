return {
	"akinsho/git-conflict.nvim",
	version = false,
	event = "BufReadPre",
	config = function()
		-- nvim 0.11 removed vim.diagnostic.disable/enable, patch for git-conflict compat
		if not vim.diagnostic.disable then
			vim.diagnostic.disable = function() end
			vim.diagnostic.enable = function() end
		end
		require("git-conflict").setup({
			default_mappings = true,
			disable_diagnostics = true,
		})
	end,
}
