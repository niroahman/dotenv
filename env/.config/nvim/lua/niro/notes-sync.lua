local notes_dir = vim.fn.expand("~/personal/vault")

local function in_notes_dir()
    local f = vim.api.nvim_buf_get_name(0)
    return f:find(notes_dir, 1, true) ~= nil
end

local function sync_push()
    if not in_notes_dir() then return end
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
    vim.fn.jobstart(
        "git add . && git diff --cached --quiet || (git commit -m 'Auto-sync: " .. filename .. "' && git push)",
        {
            cwd = notes_dir,
            on_exit = function(_, code)
                if code == 0 then
                    vim.notify("Synced to GitHub!", vim.log.levels.INFO)
                else
                    vim.notify("Git sync failed (code " .. code .. ")", vim.log.levels.WARN)
                end
            end,
        }
    )
end

local function sync_pull()
    vim.fn.jobstart("git pull --rebase", {
        cwd = notes_dir,
        on_exit = function(_, code)
            if code ~= 0 then
                vim.notify("Git pull failed!", vim.log.levels.WARN)
            end
        end,
    })
end

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.md",
    callback = sync_push,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.md",
    once = true,
    callback = function()
        if in_notes_dir() then sync_pull() end
    end,
})
