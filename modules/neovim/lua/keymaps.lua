local set_keymaps = require("utils").set_keymaps
local splits = require("smart-splits")

local keymaps = {
    [{ "n", "v" }] = {
        ["gh"] = {
            "^",
            desc = "Go to: beginning of the line (non-whitespace char)",
        },
        ["gl"] = { "$", desc = "Go to: end of the line" },
        -- ["<leader>y"] = { '"+y' },
        -- ["<leader>d"] = { '"_d' },
        -- ["<leader>p"] = { '"_dP' },
        -- ["<leader>c"] = { '"_c' },
    },
    n = {
        ["<C-Tab>"] = { "<C-^>" },
        ["<leader>w"] = { "<cmd>w<CR>", desc = "Save" },
        ["<leader>q"] = { "<cmd>q<CR>", desc = "Quit" },
        ["<leader>Q"] = { "<cmd>qa<CR>", desc = "Quit all" },
        ["<ESC>"] = {
            ":nohlsearch<Bar>:echo<CR>",
            desc = "Remove search highlights",
        },
        ["<C-d>"] = { "<C-d>zz", desc = "Down half page" },
        ["<C-u>"] = { "<C-u>zz", desc = "Down half page" },
        ["<leader>/"] = {
            function() require("Comment.api").toggle.linewise.current() end,
            desc = "Comment line",
        },
        ["n"] = { "nzzzv" },
        ["N"] = { "Nzzzv" },
        ["J"] = { "mzJ`z" },

        ["<leader>e"] = { ":Neotree toggle reveal<CR>", desc = "Open Neotree" },
        -- SPLITS
        ["<leader>v"] = { ":vsplit<CR>", desc = "Split vertically" },
        ["<leader>h"] = { ":split<CR>", desc = "Split horizontally" },

        ["<C-h>"] = { function() splits.move_cursor_left() end, desc = "Move to left split" },
        ["<C-j>"] = { function() splits.move_cursor_down() end, desc = "Move to below split" },
        ["<C-k>"] = { function() splits.move_cursor_up() end, desc = "Move to above split" },
        ["<C-l>"] = { function() splits.move_cursor_right() end, desc = "Move to right split" },
        -- TELESCOPE
        ["<leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Search files" },

        ["<leader>fF"] = {
            function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end,
            desc = "Search all files",
        },

        ["<leader>fw"] = {
            function() require("telescope.builtin").live_grep() end,
            desc = "Grep word",
        },

        ["<leader>fb"] = {
            function() require("telescope.builtin").buffers() end,
            desc = "Search buffers",
        },

        ["<leader>fh"] = {
            function() require("telescope.builtin").help_tags() end,
            desc = "Search help",
        },

        ["<leader>fm"] = {
            function() require("telescope.builtin").marks() end,
            desc = "Search marks",
        },

        ["<leader>fW"] = {
            function() require("telescope.builtin").grep_string() end,
            desc = "Search for word under cursor",
        },

        ["<leader>fc"] = {
            function() require("telescope").extensions.neoclip.default() end,
            desc = "Search clipboard",
        },

        ["<leader>U"] = {
            function() require("telescope").extensions.undo.undo() end,
            desc = "Search Undo",
        },

        -- HARPOON
        ["<leader>fa"] = {
            function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
            desc = "Harpoon menu",
        },
        ["<C-e>"] = {
            function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
            desc = "Harpoon menu",
        },
        ["<leader>a"] = {
            function() require("harpoon"):list():append() end,
            desc = "Add to Harpoon",
        },
        ["<leader>1"] = {
            function() require("harpoon"):list():select(1) end,
            desc = "Harpoon 1",
        },
        ["<leader>2"] = {
            function() require("harpoon"):list():select(2) end,
            desc = "Harpoon 2",
        },
        ["<leader>3"] = {
            function() require("harpoon"):list():select(3) end,
            desc = "Harpoon 3",
        },
        ["<leader>4"] = {
            function() require("harpoon"):list():select(4) end,
            desc = "harpoon 4",
        },

        -- LSP
        ["K"] = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover documentation",
        },
        ["<leader>ld"] = {
            function() vim.diagnostic.open_float() end,
            desc = "Hover diagnostics",
        },
        ["<leader>lD"] = {
            function()
                require("telescope.builtin").diagnostics({
                    layout_strategy = "vertical",
                })
            end,
            desc = "List all diagnostics",
        },
        ["<leader>ls"] = {
            "<cmd>AerialToggle float<CR>",
            desc = "Show document symbols",
        },
        ["gs"] = {
            "<cmd>AerialToggle float<CR>",
            desc = "Show document symbols",
        },
        ["<leader>lS"] = {
            function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
            desc = "List all symbols",
        },
        ["gS"] = {
            function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
            desc = "List all symbols",
        },
        ["<leader>la"] = {
            function() vim.lsp.buf.code_action() end,
            desc = "LSP code action",
        },
        ["<leader>ca"] = {
            function() vim.lsp.buf.code_action() end,
            desc = "LSP code action",
        },
        ["<leader>F"] = {
            function()
                require("conform").format()
                --vim.lsp.buf.format({
                --    filter = function(client) return client.name ~= "tsserver" end,
                --})
            end,
            desc = "Format code",
        },
        ["<leader>r"] = {
            function() vim.lsp.buf.rename() end,
            desc = "Rename current symbol",
        },
        ["<leader>lh"] = {
            function() vim.lsp.buf.signature_help() end,
            desc = "Signature help",
        },
        ["<leader>lR"] = { "<cmd>LspRestart<CR>", desc = "LSP Restart" },
        ["gd"] = {
            function()
                require("telescope.builtin").lsp_definitions()
                vim.cmd("normal! zz")
            end,
            desc = "Show the definition of current symbol",
        },
        ["<leader>gd"] = {
            ":vsplit | lua require('telescope.builtin').lsp_definitions()<CR> | zz",
            desc = "Show definition in a vertical split",
        },
        ["gt"] = {
            function()
                require("telescope.builtin").lsp_type_definitions()
                vim.cmd("normal! zz")
            end,
            desc = "Show type definition of current symbol",
        },
        ["<leader>gt"] = {
            ":vsplit<CR>gt",
            desc = "Show type definition in a vertical split",
        },
        ["gr"] = {
            "<cmd>Telescope lsp_references<CR>",
            desc = "Find all references of the current symbol",
        },
        ["gD"] = {
            function() vim.lsp.buf.implementation() end,
            desc = "Find all references of the current symbol",
        },
        ["<leader>gD"] = {
            ":vsplit | lua vim.lsp.buf.implementation()<CR>zz",
            desc = "Find all references of the current symbol",
        },
        ["gi"] = {
            function() require("telescope.builtin").lsp_implementations() end,
            desc = "Implementation of current symbol",
        },
        ["<leader>uw"] = {
            function()
                if vim.opt.list._value == true then
                    vim.opt.list = false
                else
                    vim.opt.list = true
                end
            end,
            desc = "Toggle whitespace",
        },
        ["<leader>uz"] = {
            function() require("zen-mode").toggle() end,
            desc = "Toggle ZenMode",
        },
        -- navigate tmux/vim splits
        -- better increments
        ["-"] = { "<c-x>", desc = "Descrement number" },
        ["+"] = { "<c-a>", desc = "Increment number" },
        ["<C-w>0"] = { "<C-w>=", desc = "Equally high and wide" },
        ["<leader>0"] = { "<C-w>=", desc = "Equally high and wide" },
        -- move lines
        ["∆"] = { ":m +1<CR>==" },
        ["˚"] = { ":m -2<CR>==" },
    },
    v = {
        ["∆"] = { ":m '>+1<CR>gv=gv" },
        ["˚"] = { ":m '<-2<CR>gv=gv" },
        ["-"] = { "<c-x>", desc = "Descrement number" },
        ["+"] = { "<c-a>", desc = "Increment number" },
        ["<"] = { "<gv" },
        [">"] = { ">gv" },
        ["p"] = { '"_dp' },
        ["P"] = { '"_dP' },
        ["<leader>/"] = {
            "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
            desc = "Toggle comment line",
        },
    },
    x = {
        ["p"] = { "P" },
        ["P"] = { "p" },
    },
    c = {
        ["<C-a>"] = { "<Home>" },
        ["<C-f>"] = { "<right>" },
        ["<C-b>"] = { "<left>" },
    },
    i = {
        ["<C-h>"] = false,
        ["<C-b>"] = { "<left>" },
        ["<C-e>"] = { "<C-o>A" },
        ["<C-f>"] = { "<right>" },
        ["<C-a>"] = { "<C-o>I" },
        ["<C-j>"] = { "<Nop>" },
        ["<C-k>"] = { "<Nop>" },
        ["<C-p>"] = { "<C-o>k" },
        ["<C-n>"] = { "<C-o>j" },
        --["<C-y>"] = { vim.fn["copilot#Accept"]("<CR>") },
    },
}

set_keymaps(keymaps)
