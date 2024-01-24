local lsp = require("lspconfig")
local conform = require("conform")
local navic = require("nvim-navic")

navic.setup({
    click = true,
    highlight = true,
    icons = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
    },
})

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then navic.attach(client, bufnr) end
end

lsp.denols.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    root_dir = lsp.util.root_pattern({
        "deno.json",
        "deno.lock",
        "deno.jsonc",
    }),
})

lsp.tsserver.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    single_file_support = false,
    root_dir = lsp.util.root_pattern({ "package.json" }),
})

lsp.astro.setup({})

lsp.html.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    filetypes = { "html", "templ" },
})

--[[ lsp.htmx.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    filetypes = { "html", "astro", "templ" },
}) ]]

lsp.cssls.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    filetypes = { "css", "scss", "less", "astro", "templ" },
    settings = {
        css = {
            lint = {
                unknownAtRules = "ignore",
            },
        },
    },
})

lsp.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    filetypes = {
        "templ",
        "astro",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
    },
    root_dir = lsp.util.root_pattern("tailwind.config.js"),
    init_options = { userLanguages = { templ = "html" } },
})

--[[ lsp.emmet_ls.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    filetypes = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "svelte",
        "pug",
        "templ",
        "typescriptreact",
        "vue",
    },
})
]]

lsp.emmet_language_server.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    filetypes = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "svelte",
        "pug",
        "templ",
        "typescriptreact",
        "vue",
    },
})

lsp.gopls.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,

    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
})

lsp.helm_ls.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    settings = {
        ["helm-ls"] = {
            yamlls = {
                path = "yaml-language-server",
            },
        },
    },
})

lsp.yamlls.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
})

lsp.jsonls.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})

lsp.nil_ls.setup({})

lsp.terraformls.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
})

lsp.lua_ls.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

lsp.ocamllsp.setup({
    on_attach = function(_, _)
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorHold" }, {
            callback = function() require("lsp.codelens").refresh_virtlines() end,
        })

        vim.keymap.set(
            "n",
            "<leader>lt",
            function() require("lsp.codelens").toggle_virtlines() end,
            { silent = true, desc = "Toggle codelens", noremap = true }
        )
    end,
    capabilities = updated_capabilities,
    get_language_id = function(_, ftype) return ftype end,
    settings = {
        codelens = { enable = true },
    },
})

lsp.biome.setup({
    single_file_support = false,
    root_dir = lsp.util.root_pattern("biome.json"),
})

-- lsp.sqls.setup {
--     on_attach = function(client, bufnr)
--         require('sqls').on_attach(client, bufnr)
--     end
-- }

--local typescript_tools = require("typescript-tools")
local rust_tools = require("rust-tools")

--typescript_tools.setup({})

rust_tools.setup({
    server = {
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set("n", "<leader>ca", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
        end,
    },
    tools = {
        hover_actions = {
            auto_focus = true,
        },
    },
})

-- LINTERS

-- FORMATTERS
--
local function hasPrettierConfig()
    if
        vim.fn.filereadable(vim.fn.getcwd() .. "/.prettierrc") == 1
        or vim.fn.filereadable(vim.fn.getcwd() .. "/.prettierrc.json") == 1
        or vim.fn.filereadable(vim.fn.getcwd() .. "/.prettierrc.yaml") == 1
        or vim.fn.filereadable(vim.fn.getcwd() .. "/.prettierrc.yml") == 1
        or vim.fn.filereadable(vim.fn.getcwd() .. "/.prettierrc.js") == 1
        or vim.fn.filereadable(vim.fn.getcwd() .. "/.prettierrc.cjs") == 1
    then
        return true
    else
        return false
    end
end

conform.setup({
    formatters_by_ft = {
        templ = { "templ" },
        typescript = { { "prettierd", "biome" } },
        javascript = { { "prettierd", "biome" } },
        astro = { { "prettierd", "biome" } },
        lua = { "stylua" },
        python = { "isort", "black" },
        dune = { "ocamllsp" },
        yaml = { "yamlfmt" },
        nix = { "nixpkgs_fmt" },
    },

    formatter = {
        biome = {
            condition = function()
                if hasPrettierConfig() then return false end
            end,
        },
        prettierd = {
            condition = function()
                -- project root dir has prettier config
                if hasPrettierConfig() then return true end
            end,
        },
    },
})

-- MISC

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- AUTOCOMPLETE

local cmp = require("cmp")
local luasnip = require("luasnip")

local snip = luasnip.snippet
local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local func = luasnip.function_node
local choice = luasnip.choice_node
local dynamicn = luasnip.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").load({
    paths = {
        "/Users/laurynas-fp/Library/Application Support/Code/User/snippets",
    },
})

--require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })

luasnip.config.setup({
    enable_autosnippets = true,
})

luasnip.add_snippets("ocaml", {
    snip({
        trig = "//",
        snippetType = "autosnippet",
    }, { text("(* "), insert(1), text(" *)"), insert(0) }),
})

cmp.setup({
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    sources = {
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "luasnip", max_item_count = 3 },
        { name = "path" },
        { name = "buffer", max_item_count = 3 },
    },
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = require("lspkind").cmp_format({
            mode = "symbol_text",
            ellipsis_char = "...",
            maxwidth = 25,
            preset = "codicons",
        }),
    },
    filetype_extend = {
        javascript = { "javascriptreact" },
        typescript = { "typescriptreact" },
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping({
            i = cmp.config.close,
            c = cmp.mapping.close(),
        }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
        }),
        ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Replace, select = false }, { "i", "s", "c" }),
        ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
})
