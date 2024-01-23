vim.cmd[[compiler cargo]]

vim.keymap.set("n", "<leader>rr", ":make run<CR>")
vim.keymap.set("n", "<leader>rc", ":make clippy<CR>")
