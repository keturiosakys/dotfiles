--[[vim.api.nvim_create_augroup("open_folds", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter" }, {
    desc = "Auto unfold on buffer read",
    group = "open_folds",
    pattern = "*",
    command = "set foldlevelstart=99",
})]]

local function is_special_buffer()
    local buftype = vim.bo.buftype
    local filetype = vim.bo.filetype
    return buftype == "terminal"
        or buftype == "quickfix"
        or buftype == "help"
        or buftype == "nofile"
        or buftype == "nowrite"
        or filetype == "harpoon"
        or filetype == "netrw"
end

vim.api.nvim_create_augroup("terminal_group", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen" }, {
    desc = "Terminal settings",
    group = "terminal_group",
    pattern = "*",
    callback = function()
        vim.cmd("startinsert")
        vim.cmd("setlocal nonumber norelativenumber")
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    desc = "Terminal focus",
    group = "terminal_group",
    pattern = "term://*",
    callback = function()
        if vim.bo.buftype == "terminal" then
            vim.cmd("startinsert")
            vim.cmd("setlocal nonumber norelativenumber")
        end
    end,
})

--Relative numbers only in active buffer and window and normal mode
vim.api.nvim_create_augroup("relative_numbers", { clear = true })
vim.api.nvim_create_autocmd({
    "BufEnter",
    "BufWinEnter",
    "WinEnter",
    "FocusGained",
    "InsertLeave",
    "TermOpen",
}, {
    desc = "Relative numbers only in active buffer and normal mode",
    group = "relative_numbers",
    pattern = "*",
    callback = function()
        if not is_special_buffer() then
            vim.o.relativenumber = true
        else
            vim.o.relativenumber = false
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "FocusLost", "InsertEnter" }, {
    desc = "Relative numbers only in active buffer and normal mode",
    group = "relative_numbers",
    pattern = "*",
    callback = function()
        if not is_special_buffer() then vim.o.relativenumber = false end
    end,
})

-- Highlight on yank
vim.api.nvim_create_augroup("yank_group", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    desc = "Highlight yanked text",
    group = "yank_group",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.cmd("normal! zz")
        end
    end,
})

--[[ vim.api.nvim_create_augroup("cursor_group", { clear = true })
vim.api.nvim_create_autocmd("VimLeave", {
    desc = "Reset cursor",
    group = "cursor_group",
    command = "set guicursor=a:ver25,a:blinkwait600-blinkoff100-blinkon200",
})
]]

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if vim.opt.foldmethod:get() == "expr" then vim.schedule(function() vim.opt.foldmethod = "expr" end) end
    end,
})
