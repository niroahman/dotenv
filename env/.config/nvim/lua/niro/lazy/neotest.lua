return {
	{
		"nvim-neotest/neotest",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/nvim-nio",
			"nvim-neotest/neotest-jest",
		},
		discovery = {
			enabled = false,
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-jest")({
						jest_test_discovery = true,
						jestCommand = "yarn test --",
						jestConfigFile = "custom.jest.config.ts",
						-- jestConfigFile = "jest.config.ts",
						env = { CI = true },
						cwd = function(path)
							return vim.fn.getcwd()
						end,
					}),
				},
			})

			vim.keymap.set("n", "<leader>tc", function()
				neotest.run.run()
			end)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>tw",
				"<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
				{}
			)
		end,
	},
}
