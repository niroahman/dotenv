return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_organize_imports", "ruff_format" },
			rust = { "rustfmt" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			astro = { "prettierd", "prettier", stop_after_first = true },
		},
		formatters = {
			prettierd = {
				command = "prettierd",
				args = { "$FILENAME" },
				cwd = function(ctx)
					local found = vim.fs.find(
						{ ".git", "package.json", "node_modules", "tailwind.config.js", ".prettierrc.js", "prettier.config.js" },
						{ path = vim.fs.dirname(ctx.filename), upward = true, type = "directory", limit = 1 }
					)
					if found and #found > 0 then
						return vim.fs.dirname(found[1])
					end
					return vim.loop.cwd()
				end,
			},
			prettier = {
				command = "node_modules/.bin/prettier",
			},
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}
