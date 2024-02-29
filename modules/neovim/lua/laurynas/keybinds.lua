local set_keymaps = require("laurynas.utils").set_keymaps

local function toggle_term()
    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
        local buffer_name = vim.api.nvim_buf_get_name(buffer)
        if string.sub(buffer_name, 1, 7) == "term://" then
            vim.api.nvim_win_set_buf(0, buffer)
            return
        end
    end
    vim.api.nvim_command(":terminal")
end

local harpoon = require("harpoon")

local symbols = require("laurynas.symbols")

local keymaps = {
    [{ "n", "v" }] = {
        ["gh"] = { "^", desc = "Go to: beginning of the line (non-whitespace char)" },
        ["gl"] = { "$", desc = "Go to: end of the line" },
        ["<leader>S"] = {
            function() require("spectre").toggle() end,
            desc = "Spectre search",
        },
        ["<leader>sw"] = { function() require("spectre").open_visual({ select_word = true }) end, desc = "Search current word" },
        ["g1"] = { "<cmd>tabn 1<CR>" },
        ["g2"] = { "<cmd>tabn 2<CR>" },
        ["g3"] = { "<cmd>tabn 3<CR>" },
    },
    [{ "n", "x" }] = {
        ["c"] = { '"_c' },
        ["s"] = { '"_s' },
    },
    t = {
        ["<Esc><Esc>"] = { "<C-\\><C-n>" },
        ["<C-d>"] = { "<C-\\><C-n><C-d>zzA" },
        ["<C-u>"] = { "<C-\\><C-n><C-u>zzA" },
        ["<C-i>"] = { "<C-\\><C-n><C-i>zz" },
        ["<C-o>"] = { "<C-\\><C-n><C-o>zz" },
        ["<Tab>"] = { "<Tab>" },
        ["<C-^>"] = { "<C-\\><C-n><C-^>" },
        ["<C-Tab>"] = { "<C-\\><C-n><C-^>" },
    },
    [{ "n", "t" }] = {
        ["<C-q>"] = { "<cmd>q<CR>", desc = "Quit" },
        -- ["<F1>"] = { "<cmd>tabn 1<CR>" },
        -- ["<F2>"] = { "<cmd>tabn 2<CR>" },
        -- ["<F3>"] = { "<cmd>tabn 3<CR>" },
        -- ["<F4>"] = { "<cmd>tabn 4<CR>" },
        -- ["<F5>"] = { "<cmd>tabn 5<CR>" },

        ["<F1>"] = { function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
        ["<F2>"] = { function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
        ["<F3>"] = { function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
        ["<F4>"] = { function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
        ["<F5>"] = { function() require("harpoon"):list():select(5) end, desc = "Harpoon 5" },

        ["<C-h>"] = { "<cmd>NavigatorLeft<CR>", desc = "Move to left split" },
        ["<C-j>"] = { "<cmd>NavigatorDown<CR>", desc = "Move to below split" },
        ["<C-k>"] = { "<cmd>NavigatorUp<CR>", desc = "Move to above split" },
        ["<C-l>"] = { "<cmd>NavigatorRight<CR>", desc = "Move to right split" },

        ["<Up>"] = { "<cmd>resize +2<CR>", desc = "Resize down" },
        ["<Down>"] = { "<cmd>resize -2<CR>", desc = "Resize up" },
        ["<Left>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize right" },
        ["<Right>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize left" },
    },
    n = {
        ["[t"] = { "<cmd>tabprev<CR>", desc = "Previous tab" },
        ["]t"] = { "<cmd>tabnext<CR>", desc = "Next tab" },
        ["[b"] = { "<cmd>bprev<CR>", desc = "Previous buffer" },
        ["]b"] = { "<cmd>bnext<CR>", desc = "Next buffer" },

        ["<C-t>"] = { function() toggle_term() end, desc = "Open Terminal" },
        ["<leader>t"] = { function() toggle_term() end, desc = "Open Terminal" },
        ["<leader>w"] = { "<cmd>w<CR>", desc = "Save" },
        ["<leader>x"] = { "<cmd>bdelete<CR>", desc = "Kill buffer" },
        ["<leader>q"] = { "<cmd>q<CR>", desc = "Quit" },
        ["<leader>Q"] = { "<cmd>qa<CR>", desc = "Quit all" },
        ["<ESC>"] = { ":nohlsearch<Bar>:echo<CR>", desc = "Remove search highlights" },
        ["<C-Tab>"] = { "<C-^>" },
        ["<leader>/"] = { function() require("Comment.api").toggle.linewise.current() end, desc = "Comment line" },
        -- always center the viewport after executing vertical movement
        ["<C-d>"] = { "<C-d>zz" },
        ["<C-u>"] = { "<C-u>zz" },
        ["<C-i>"] = { "<C-i>zz" },
        ["<C-o>"] = { "<C-o>zz" },
        ["{"] = { "{zz" },
        ["}"] = { "}zz" },
        ["#"] = { "#zz" },
        ["%"] = { "%zz" },
        ["*"] = { "*zz" },
        ["gg"] = { "ggzz" },
        ["G"] = { "Gzz" },
        ["n"] = { "nzzzv" },
        ["N"] = { "Nzzzv" },
        ["J"] = { "mzJ`z" },

        ["S"] = {
            function()
                local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
                local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
                vim.api.nvim_feedkeys(keys, "n", false)
            end,
            desc = "Quick find/replace for the word under the cursor",
        },

        ["<leader>ga"] = { "<cmd>Git add %<CR><CR>", desc = "Stage current file" },

        ["<leader>e"] = { ":Neotree toggle reveal<CR>", desc = "Open Neotree" },
        -- SPLITS
        ["<leader>v"] = { ":vsplit<CR>", desc = "Split vertically" },
        ["<leader>h"] = { ":split<CR>", desc = "Split horizontally" },
        -- TELESCOPE
        ["<leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Search files" },
        ["<leader>."] = { function() require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Search files in cwd" },

        ["<leader>fF"] = {
            function() require("telescope.builtin").find_files({ hidden = true }) end,
            desc = "Search all files",
        },

        ["<leader>fG"] = {
            function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end,
            desc = "Search all files including ignored",
        },

        ["<leader>fw"] = {
            function() require("telescope.builtin").live_grep() end,
            desc = "Grep word",
        },

        ["<leader>fb"] = {
            function() require("telescope.builtin").buffers({ preview = false }) end,
            desc = "Search buffers",
        },

        ["<leader>b"] = {
            function() require("telescope.builtin").buffers({ preview = false }) end,
            desc = "Search buffers",
        },
        ["<leader>fh"] = {
            function() require("telescope.builtin").help_tags({ preview = false }) end,
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

        ["<leader>ft"] = { ":TodoTelescope<CR>", desc = "Search files" },

        ["<leader>U"] = {
            function() require("undotree").toggle() end,
            desc = "Search Undo",
        },

        -- HARPOON
        ["<leader>fa"] = { function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon menu" },
        ["<C-e>"] = { function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon menu" },
        ["<leader>a"] = { function() harpoon:list():append() end, desc = "Add to Harpoon" },
        ["<leader>1"] = { function() harpoon:list():select(1) end, desc = "Harpoon 1" },
        ["<leader>2"] = { function() harpoon:list():select(2) end, desc = "Harpoon 2" },
        ["<leader>3"] = { function() harpoon:list():select(3) end, desc = "Harpoon 3" },
        ["<leader>4"] = { function() harpoon:list():select(4) end, desc = "harpoon 4" },

        -- LSP
        ["K"] = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover documentation",
        },
        ["<leader>d"] = {
            function() vim.diagnostic.open_float() end,
            desc = "Hover diagnostics",
        },
        ["<leader>D"] = {
            function() require("telescope.builtin").diagnostics() end,
            desc = "List all diagnostics",
        },
        ["]d"] = {
            function() vim.diagnostic.goto_next() end,
            desc = "Go to next diagnostic",
        },
        ["[d"] = {
            function() vim.diagnostic.goto_prev() end,
            desc = "Go to next diagnostic",
        },
        -- ["gs"] = { "<cmd>AerialToggle<CR>", desc = "Show document symbols" },
        ["gs"] = {
            function()
                -- NOTE: Workaround for https://github.com/stevearc/aerial.nvim/issues/331
                require("aerial").refetch_symbols()
                vim.cmd.AerialToggle("float")
                vim.cmd.doautocmd("BufWinEnter")
            end,
            desc = "Show document symbols",
        },
        ["<leader>fs"] = { function() symbols.get() end, desc = "Show document symbols" },
        -- ["gs"] = { function() symbols.get() end, desc = "Show document symbols" },
        ["<leader>fS"] = { function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "List all symbols" },
        ["gS"] = { function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "List all symbols" },

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
                require("conform").format({ lsp_fallback = true })
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
            function() vim.lsp.buf.type_definition() end,
            desc = "Find all references of the current symbol",
        },
        ["<leader>gt"] = {
            ":vsplit | lua function() vim.lsp.buf.type_definition() vim.cmd('normal! zz') end <CR> | zz",
            desc = "Show definition in a vertical split",
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
                if vim.g.whitespace == true then
                    vim.opt.listchars = {
                        tab = "› ",
                        eol = "¬",
                        extends = "⟩",
                        precedes = "⟨",
                        trail = "·",
                        space = "·",
                        nbsp = "⋅",
                    }
                    vim.g.whitespace = false
                else
                    vim.opt.listchars = {
                        tab = "  ",
                        eol = "¬",
                        trail = "·",
                    }
                    vim.g.whitespace = true
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
        ["<leader>="] = { "<C-w>=", desc = "Equally high and wide" },
        -- move lines
        -- ["∆"] = { ":m +1<CR>==" },
        -- ["˚"] = { ":m -2<CR>==" },
    },
    v = {
        -- ["∆"] = { ":m '>+1<CR>gv=gv" },
        -- ["˚"] = { ":m '<-2<CR>gv=gv" },
        ["-"] = { "<c-x>", desc = "Descrement number" },
        ["+"] = { "<c-a>", desc = "Increment number" },
        ["<"] = { "<gv" },
        [">"] = { ">gv" },
        ["p"] = { '"_dP' },
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
        ["<C-k>"] = { function() vim.lsp.buf.signature_help() end, desc = "Show function signature" },
        ["<C-p>"] = { "<C-o>k" },
        ["<C-n>"] = { "<C-o>j" },
        --["<C-y>"] = { vim.fn["copilot#Accept"]("<CR>") },
    },
}

set_keymaps(keymaps)
