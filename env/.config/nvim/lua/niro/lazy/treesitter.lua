-- nvim-treesitter `main` branch — required for Neovim 0.12+.
-- The legacy `master` branch was archived upstream and is not API-compatible
-- with Neovim 0.12. See https://github.com/nvim-treesitter/nvim-treesitter
local ensure_installed = {
    "vimdoc", "javascript", "typescript", "tsx", "c", "lua", "rust",
    "jsdoc", "bash", "vim", "markdown", "markdown_inline", "luadoc",
    "html", "css", "json", "yaml", "go", "python", "query", "regex",
    "diff", "gitcommit", "astro",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        -- Register custom templ parser before TSUpdate runs.
        vim.api.nvim_create_autocmd("User", {
            pattern = "TSUpdate",
            callback = function()
                require("nvim-treesitter.parsers").templ = {
                    install_info = {
                        url = "https://github.com/vrischmann/tree-sitter-templ",
                        branch = "master",
                        queries = "queries",
                    },
                }
            end,
        })

        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        vim.treesitter.language.register("templ", "templ")

        require("nvim-treesitter").install(ensure_installed)

        -- Enable highlighting and indent for installed parsers.
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local buf = args.buf
                local ft = vim.bo[buf].filetype
                local lang = vim.treesitter.language.get_lang(ft) or ft
                if lang and pcall(vim.treesitter.start, buf, lang) then
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
