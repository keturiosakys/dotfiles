local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")

require("telescope").setup({
    defaults = {
        color_devicons = false,
        disable_devicons = true,
        path_display = { "truncate" },
        dynamic_preview_title = true,
        sorting_strategy = "descending",
        layout_strategy = "flex",
        layout_config = {
            flip_columns = 160,
        },
        preview = {
            filesize_limit = 0.1,
        },

        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-CR>"] = actions.file_vsplit,
                ["<C-t>"] = actions.file_tab,
                ["<M-p>"] = actions_layout.toggle_preview,
            },
            n = {
                ["q"] = actions.close,
                ["<M-p>"] = actions_layout.toggle_preview,
            },
        },
    },

    extensions = {
        aerial = {
            show_nesting = {
                ["_"] = false, -- This key will be the default
                json = true, -- You can set the option for specific filetypes
                yaml = true,
            },
        },
        ["zf-native"] = {
            file = {
                -- override default telescope file sorter
                enable = true,

                -- highlight matching text in results
                highlight_results = true,

                -- enable zf filename match priority
                match_filename = true,
            },

            -- options for sorting all other items
            generic = {
                -- override default telescope generic item sorter
                enable = true,

                -- highlight matching text in results
                highlight_results = true,

                -- disable zf filename match priority
                match_filename = false,
            },
        },
    },
})

require("telescope").load_extension("zf-native")
require("telescope").load_extension("aerial")
