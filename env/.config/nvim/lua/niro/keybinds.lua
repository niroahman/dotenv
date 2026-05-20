vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--- move line up and down on visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
	require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end)

-- Allow pasting multiple times
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy to system clipboard with motions
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- copy line to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>P", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })
vim.keymap.set("n", "]l", "<cmd>lnext<CR>zz", { desc = "Next loclist" })
vim.keymap.set("n", "[l", "<cmd>lprev<CR>zz", { desc = "Prev loclist" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a')

vim.keymap.set("n", "<leader>el", 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i')

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- copy file:line to clipboard for referencing in claude/terminal
vim.keymap.set("n", "<leader>cl", function()
	local ref = vim.fn.expand("%:p") .. ":" .. vim.fn.line(".")
	vim.fn.setreg("+", ref)
	vim.notify(ref)
end, { desc = "Copy file:line to clipboard" })

-- oil.nvim
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory in Oil" })

vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })
vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Format current file" })

vim.keymap.set(
	"n",
	"<leader>ts",
	"<cmd>lua require('neotest').summary.toggle()<cr>",
	{ desc = "Toggle neotest summary" }
)

vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-y>"
	else
		return "<Tab>"
	end
end, { desc = "remap suggestion to ctrl enter", expr = true, noremap = true })
