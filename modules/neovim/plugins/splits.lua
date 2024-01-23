--         {
--             "<Up>",
--             function() require("smart-splits").resize_up(2) end,
--             desc = "Resize up",
--         },
--         {
--             "<Down>",
--             function() require("smart-splits").resize_down(2) end,
--             desc = "Resize down",
--         },
--         {
--             "<Left>",
--             function() require("smart-splits").resize_left(2) end,
--             desc = "Resize left",
--         },
--         {
--             "<Right>",
--             function() require("smart-splits").resize_right(2) end,
--             desc = "Resize right",
--         },
--     },

require("smart-splits").setup({
    ignored_filetypes = {
        "nofile",
        "quickfix",
        "qf",
        "prompt",
    },
    ignored_buftypes = { "nofile" },
})
