local harpoon = require("harpoon")

harpoon:setup({
    settings = {
        save_on_toggle = true,
    },
})

harpoon:extend({
    UI_CREATE = function(ctx)
        vim.keymap.set(
            "n",
            "<C-CR>",
            function() harpoon.ui:select_menu_item({ vsplit = true }) end,
            { buffer = ctx.bufnr }
        )
        vim.keymap.set(
            "n",
            "<C-t>",
            function() harpoon.ui:select_menu_item({ tabedit = true }) end,
            { buffer = ctx.bufnr }
        )
    end,
})
