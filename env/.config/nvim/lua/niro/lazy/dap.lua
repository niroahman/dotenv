return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	keys = {
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
		{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional Breakpoint" },
		{ "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
		{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
		{ "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
		{ "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
		{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
		{ "<leader>du", function() require("dapui").toggle() end, desc = "Toggle UI" },
		{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
		{ "<leader>dgt", function() require("dap-go").debug_test() end, desc = "Debug Go Test" },
		{ "<leader>dgl", function() require("dap-go").debug_last_test() end, desc = "Debug Last Go Test" },
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		require("nvim-dap-virtual-text").setup()
		dapui.setup()
		require("dap-go").setup()

		-- Python
		require("dap-python").setup(vim.fn.exepath("python3"))

		-- JS/TS via mason-installed js-debug-adapter
		local js_debug = require("mason-registry").get_package("js-debug-adapter"):get_install_path()
			.. "/js-debug/src/dapDebugServer.js"
		for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
			dap.adapters[lang] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = { command = "node", args = { js_debug, "${port}" } },
			}
		end
		for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
			dap.configurations[lang] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end

		dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
		dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
		dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
	end,
}
