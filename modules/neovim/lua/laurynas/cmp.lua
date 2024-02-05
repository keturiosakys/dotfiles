
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
require("luasnip.loaders.from_vscode").lazy_load({
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
        -- format = require("lspkind").cmp_format({
        --     mode = "symbol_text",
        --     ellipsis_char = "...",
        --     maxwidth = 25,
        --     preset = "codicons",
        -- }),
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
