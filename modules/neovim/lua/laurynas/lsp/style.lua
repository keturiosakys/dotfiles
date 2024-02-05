vim.fn.sign_define("DiagnosticSignError", { text = "!", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "?", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "> ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "~", texthl = "DiagnosticSignHint" })

vim.diagnostic.config({
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = true,
    signs = {
        linehl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticLineHlError",
            [vim.diagnostic.severity.WARN] = "DiagnosticLineHlWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticLineHlInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticLineHlHint",
        },
    },
    update_in_insert = false,
    severity_sort = true,
})

require("lspconfig.ui.windows").default_options.border = "rounded"
