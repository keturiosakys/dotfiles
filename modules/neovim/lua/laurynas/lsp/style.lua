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

local border = {
    { "🭽", "FloatBorder" },
    { "▔", "FloatBorder" },
    { "🭾", "FloatBorder" },
    { "▕", "FloatBorder" },
    { "🭿", "FloatBorder" },
    { "▁", "FloatBorder" },
    { "🭼", "FloatBorder" },
    { "▏", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

require("lspconfig.ui.windows").default_options.border = "rounded"

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    silent = true,
    focusable = false,
})
