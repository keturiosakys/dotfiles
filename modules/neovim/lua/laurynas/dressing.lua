require("dressing").setup({
    input = {
        default_prompt = "> ",
        builtin = {
            winhighlight = "Normal:Normal,NormalNC:Normal",
        },
        get_config = function()
            if vim.api.nvim_buf_get_option(0, "filetype") == "neo-tree" then return { enabled = false } end
        end,
    },

    select = {
        backend = { "builtin", "nui" },

        builtin = {
            winhighlight = "Normal:Normal,NormalNC:Normal",
            relative = "cursor",
        },
    },
})
