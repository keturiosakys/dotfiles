require("copilot").setup({
    suggestion = {
        enabled = false,
        auto_trigger = true,
        keymap = {
            accept = "<C-y>",
        },
    },
    panel = { enabled = false },
})
require("copilot_cmp").setup()
