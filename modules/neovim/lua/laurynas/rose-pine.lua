local options = {
    variant = "auto",
    dark_variant = "moon",
    dim_inactive_windows = true,

    styles = {
        italic = false,
    },

    groups = {
        border = "text",
    },

    highlight_groups = {
        NormalFloat = { fg = "text", bg = "base" },
        FloatBorder = { fg = "text", bg = "base" },
        TelescopePromptTitle = { fg = "text", bg = "base" },
        TelescopeBorder = { fg = "subtle", bg = "base" },
        TelescopeNormal = { fg = "text", bg = "base" },
        TelescopePromptNormal = { fg = "text", bg = "base" },
        WhichKeyFloat = { fg = "text", bg = "base" },
        WhichKeyBorder = { fg = "subtle", bg = "base" },
        HarpoonBorder = { fg = "subtle", bg = "base" },
        HarpoonWindow = { fg = "text", bg = "base" },
        VertSplit = { fg = "text", bg = "base" },
        NonText = { fg = "highlight_high", bg = "NONE" },
        VirtNonText = { fg = "muted", bg = "base" },

        DiagnosticLineHlError = { bg = "love", blend = 10 },
        DiagnosticLineHlWarn = { bg = "gold", blend = 10 },
        DiagnosticLineHlInfo = { bg = "foam", blend = 10 },
        DiagnosticLineHlHint = { bg = "iris", blend = 10 },
    },
}

require("rose-pine").setup(options)

vim.cmd.colorscheme("rose-pine")
