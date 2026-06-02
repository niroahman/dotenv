-- nvim-treesitter removed: rewrite requires tree-sitter CLI not available on this server.
-- Builtin treesitter (nvim 0.12.2) handles highlight/indent natively.
-- Parsers installed at: /opt/nvim-linux-x86_64/lib/nvim/parser/
-- To add parsers: :TSInstall <lang> via Mason or copy .so files manually.
vim.treesitter.language.register("markdown", "mdx")
return {}
