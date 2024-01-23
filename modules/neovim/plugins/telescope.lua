local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = "▶︎ ",
        color_devicons = true,
        path_display = { "truncate" },
        dynamic_preview_title = true,
        sorting_strategy = "descending",
        layout_strategy = "flex",

        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-CR>"] = actions.file_vsplit,
            },
            n = { ["q"] = actions.close },
        },
    },

    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
        undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
                preview_height = 0.8,
                mirror = true,
            },
        },
        aerial = {
            show_nesting = {
                ["_"] = false, -- This key will be the default
                json = true,   -- You can set the option for specific filetypes
                yaml = true,
            },
        },
    },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("undo")

