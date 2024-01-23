vim.cmd([[ Copilot disable ]])
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

vim.api.nvim_create_user_command("TestHdl", function()
    local test_file = string.sub(vim.fn.expand("%:p"), 1, -4) .. "tst"
    vim.cmd(
        "!" .. vim.loop.cwd() .."tools/HardwareSimulator.sh "
            .. test_file
    )
end, {})

vim.api.nvim_set_keymap("n", "<leader>R", ":TestHdl<CR>", { noremap = true })
