vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

vim.fn.sign_define(
    "DiagnosticSignError",
    { text = " ", texthl = "DiagnosticSignError" }
)
vim.fn.sign_define(
    "DiagnosticSignWarn",
    { text = " ", texthl = "DiagnosticSignWarn" }
)
vim.fn.sign_define(
    "DiagnosticSignInfo",
    { text = " ", texthl = "DiagnosticSignInfo" }
)
vim.fn.sign_define(
    "DiagnosticSignHint",
    { text = "H", texthl = "DiagnosticSignHint" }
)

vim.g.neo_tree_remove_legacy_commands = 1

require("neo-tree").setup({
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    use_popups_for_input = false,
    sort_function = nil,
    filesystem = {
        hijack_netrw_behavior = "open_current",
        filtered_items = {
            always_show = {
                ".github",
                ".gitignore",
                ".vscode",
                ".env*",
            },
        },
        commands = {
            system_open = function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                -- macOs: open file in default application in the background.
                vim.api.nvim_command("silent !open -g " .. path)
            end,
        },
        renderers = {
            file = {
                { "icon" },
                { "name", use_git_status_colors = true },
                { "diagnostics" },
                { "git_status", highlight = "NeoTreeDimText" },
            },
        },
    },
    default_component_configs = {
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            default = "*",
            highlight = "NeoTreeFileIcon",
        },
        modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted = "✖", -- this can only be used in the git_status source
                renamed = "", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored = "",
                unstaged = "",
                staged = "",
                conflict = "",
            },
        },
    },
    nesting_rules = {
        js = {
            "js.map",
            "d.ts",
            "d.ts.map",
            "min.js",
            "cjs",
            "cjs.map",
            "mjs",
            "mjs.map",
        },
        ts = { "d.ts", "d.ts.map", "test.ts", "spec.ts" },
    },
    window = {
        position = "current",
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["l"] = "open",
            ["o"] = "system_open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            ["h"] = "close_node",
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = {
                "add",
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                    show_path = "relative", -- "none", "relative", "absolute"
                },
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["Y"] = "copy",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["n"] = {
                "add",

                config = {
                    show_path = "relative", -- "none", "relative", "absolute"
                },
            }, -- takes text input for destination, also accepts the optional config.show_path option like "add":
            ["c"] = {
                "add",

                config = {
                    show_path = "relative", -- "none", "relative", "absolute"
                },
            }, -- takes text input for destination, also accepts the optional config.show_path option like "add":
            ["m"] = {
                "move",
                config = {
                    show_path = "absolute",
                },
            }, -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
        },
    },
    diagnostics = {
        renderers = {
            file = {
                { "indent" },
                { "icon" },
                { "grouped_path" },
                { "name" },
                { "diagnostic_count", show_when_none = true },
                { "split_diagnostic_counts", left_padding = 1 },
                { "clipboard" },
            },
            diagnostic = {
                { "indent" },
                { "icon" },
                { "name" },
                { "source" },
                { "code" },
                { "position" },
            },
        },
    },
})