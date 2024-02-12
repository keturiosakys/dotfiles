local options = {
    variant = "auto",
    -- dark_variant = "moon",
    dim_inactive_windows = true,
    extend_background_behind_borders = true,

    styles = {
        italic = false,
        transparency = true,
    },

    groups = {
        border = "text",
    },

    highlight_groups = {
        NormalFloat = { fg = "text", bg = "surface" },
        FloatBorder = { fg = "text", bg = "NONE" },
        TelescopeBorder = { fg = "subtle", bg = "None" },
        TelescopeNormal = { fg = "text", bg = "None" },
        TelescopePromptTitle = { fg = "text", bg = "NONE" },
        TelescopePromptBorder = { fg = "text", bg = "NONE" },
        TelescopePromptPrefix = { fg = "text", bg = "NONE" },
        TelescopePromptNormal = { fg = "text", bg = "NONE" },
        TelescopeResultsNormal = { fg = "text", bg = "NONE" },
        TelescopePreviewNormal = { fg = "text", bg = "NONE" },
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
