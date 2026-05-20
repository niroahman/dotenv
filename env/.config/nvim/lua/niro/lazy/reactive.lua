return {
	"rasulomaroff/reactive.nvim",
	config = function()
		require("reactive").setup({
			-- You can also set default preset
			default_preset = "mypreset",

			--builtin = { cursorline = true, cursor = true, modemsg = true },
		})
		require("reactive").add_preset({
			name = "mypreset",
			init = function()
				vim.opt.guicursor:append("a:MyCursor")
				-- making our cursor to use `MyCursor` highlight group
			end,
			modes = {
				n = {
					winhl = {
						-- we use `winhl` because we want to highlight CursorLine only in a current window, not in all of them
						-- if you want to change global highlights, use the `hl` field instead.
						--CursorLine = { bg = "#333333" },
					},
					hl = {
						MyCursor = { bg = "#cc33aa" },
					},
				},
				v = {
					winhl = {
						-- we use `winhl` because we want to highlight CursorLine only in a current window, not in all of them
						-- if you want to change global highlights, use the `hl` field instead.
						--CursorLine = { bg = "#668800" },
					},
					hl = {
						MyCursor = { bg = "#ddee00" },
					},
				},
				no = {
					-- You can also specify winhl and hl that will be applied with every operator
					winhl = {},
					hl = {},
					operators = {
						d = {
							winhl = {
								CursorLine = { bg = "#450a0a" },
							},
							hl = {
								MyCursor = { bg = "#fca5a5" },
							},
						},
						y = {
							winhl = {
								CursorLine = { bg = "#422006" },
							},
							hl = {
								MyCursor = { bg = "#fdba74" },
							},
						},
					},
				},
				i = {
					winhl = {
						CursorLine = { bg = "#042f2e" },
					},
					hl = {
						MyCursor = { bg = "#5eea24" },
					},
				},
			},
		})
	end,
}
