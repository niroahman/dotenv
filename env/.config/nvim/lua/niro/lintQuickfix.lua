-- 1. Define the function (local is fine and recommended)
local function run_yarn_lint_quickfix()
	-- Set options (using vim.opt or vim.opt_local)
	vim.opt.makeprg = "yarn lint"
	vim.opt.errorformat = "%f:%l:%c: %t%n: %m" -- Adjust format if needed!

	-- Run the make command
	vim.cmd("make")

	-- Optional: Automatically open the quickfix window
	if #vim.fn.getqflist() > 0 then
		vim.cmd("copen")
	end
end

-- 2. Create a Neovim User Command that calls the Lua function
-- Add this to your init.lua after the function definition
vim.cmd("command! YarnLintQuickfix lua run_yarn_lint_quickfix()")

-- 3. (Optional) Create a Keymap that calls the Lua function
-- Add this to your init.lua
vim.api.nvim_set_keymap("n", "<leader>L", ":lua run_yarn_lint_quickfix()<CR>", { noremap = true, silent = true })
