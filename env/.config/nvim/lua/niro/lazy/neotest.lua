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
			"nvim-neotest/neotest-python",
		},
		discovery = {
			enabled = false,
		},
		config = function()
			local neotest = require("neotest")

			local function detect_jest_cmd(path)
				local root = vim.fn.getcwd()
				if vim.fn.filereadable(root .. "/pnpm-lock.yaml") == 1 then
					return "pnpm test --"
				elseif vim.fn.filereadable(root .. "/yarn.lock") == 1 then
					return "yarn test --"
				else
					return "npm test --"
				end
			end

			neotest.setup({
				adapters = {
					require("neotest-jest")({
						jest_test_discovery = true,
						jestCommand = detect_jest_cmd,
						env = { CI = true },
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
					require("neotest-python")({
						dap = { justMyCode = false },
						runner = "pytest",
					}),
				},
			})

			vim.keymap.set("n", "<leader>tc", function()
				neotest.run.run()
			end)
			vim.keymap.set("n", "<leader>tw", function()
				neotest.run.run({ jestCommand = "jest --watch " })
			end)
		end,
	},
}
