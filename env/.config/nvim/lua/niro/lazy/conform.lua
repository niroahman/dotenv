return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
			-- You can customize some of the format options for the filetype (:help conform.format)
			rust = { "rustfmt" },
			-- Conform will run the first available formatter
			javascript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		},
		-- Ensure Prettier is configured to use the project's version
		formatters = {
			prettierd = {
				command = "prettierd",
				-- `prettierd` usually expects the file path as an argument.
				-- This helps it establish the project context for that file.
				args = { "$FILENAME" }, -- "$FILENAME" is a placeholder conform.nvim replaces with the file path.

				-- Explicitly setting the Current Working Directory (CWD) to the project root
				-- is highly recommended. This helps `prettierd` locate `node_modules`,
				-- `package.json`, `.prettierrc.*`, and `tailwind.config.js`.
				cwd = function(ctx)
					-- Attempt to find the project root using common markers.
					-- This requires Neovim 0.8+ for vim.fs.find.
					-- You might need to adjust markers based on your project structure.
					local patterns = {
						".git",
						"package.json",
						"node_modules",
						"tailwind.config.js",
						".prettierrc.js",
						"prettier.config.js",
					}
					local found_root_marker = vim.fs.find(
						patterns,
						{ path = vim.fs.dirname(ctx.filename), upward = true, type = "directory", limit = 1 }
					)
					if found_root_marker and #found_root_marker > 0 then
						return vim.fs.dirname(found_root_marker[1])
					end
					-- Fallback to Neovim's current working directory if no root marker is found.
					return vim.loop.cwd()
				end,

				-- Optional: Condition to only run if prettierd is executable and project has prettier
				-- condition = function(ctx)
				--   if not vim.fn.executable("prettierd") == 1 then return false end
				--   local project_root = vim.fs.find({"node_modules/prettier"}, { path = vim.fs.dirname(ctx.filename), upward = true, type = "directory", limit = 1 })
				--   return project_root and #project_root > 0
				-- end,
			},

			prettier = {
				-- This is often the crucial part:
				command = "node_modules/.bin/prettier", -- Or try explicitly: "npx prettier" or "yarn prettier"
				-- Ensure it finds project config and plugins
				-- conform.nvim usually handles finding the local binary if available in node_modules/.bin
				-- but sometimes needs a hint or specific setup if your environment is complex.
				-- Check if you need to specify `cwd` or if it's inheriting correctly.
			},
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}
