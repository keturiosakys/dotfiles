require("aerial").setup({
    show_guides = true,
    close_on_select = true,
    filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
        "Variable",
    },
    close_automatic_events = {
        "unfocus",
        "switch_buffer",
        "unsupported",
    },
    keymaps = {
        ["<esc>"] = "actions.close",
        ["<C-n>"] = "actions.down_and_scroll",
        ["<C-p>"] = "actions.up_and_scroll",
    },
})
