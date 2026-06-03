require("niro.set")

-- Filetype overrides (must run before lazy so ft-triggered plugins load correctly)
vim.filetype.add({ extension = { mdx = "mdx" } })
require("niro.keybinds")
-- require("niro.lintQuickfix")

require("niro.lazy_init")
require("niro.notes-sync")
