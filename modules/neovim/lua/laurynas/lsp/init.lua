local lsp = require("lspconfig")
local conform = require("conform")

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

local on_attach = function(client, _)
    local active_clients = vim.lsp.get_active_clients()
    if client.name == "denols" then
        for _, client_ in pairs(active_clients) do
            -- stop tsserver if denols is already active
            if client_.name == "tsserver" then client_.stop() end
        end
    elseif client.name == "tsserver" then
        for _, client_ in pairs(active_clients) do
            -- prevent tsserver from starting if denols is already active
            if client_.name == "denols" then client.stop() end
        end
    end
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

lsp.astro.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
})

lsp.html.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    filetypes = { "html", "templ", "heex" },
})

--[[ lsp.htmx.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    filetypes = { "html", "astro", "templ" },
}) ]]

lsp.cssls.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    filetypes = {
        "css",
        "scss",
        "less",
        "templ",
    },
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
        "astro",
        "heex",
        "javascript",
        "javascriptreact",
        "templ",
        "typescript",
        "typescriptreact",
    },
    root_dir = lsp.util.root_pattern("tailwind.config.js"),
    init_options = { userLanguages = { templ = "html" } },
})

lsp.emmet_language_server.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    filetypes = {
        "astro",
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "heex",
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

lsp.clangd.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    cmd = { "clangd", "--background-index", "--clang-tidy", "--suggest-missing-includes" },
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

--[[ lsp.elixirls.setup({
    on_attach = on_attach,
    capabilities = updated_capabilities,
    cmd = { "elixir-ls" },
    settings = {
        elixirLS = {
            dialyzerEnabled = true,
            fetchDeps = false,
        },
    },
}) ]]

lsp.lexical.setup({
    cmd = { "/etc/profiles/per-user/laurynask/bin/lexical" },
    root_dir = function(fname) return lsp.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir() end,
    settings = {
        elixirLS = {
            dialyzerEnabled = true,
        },
    },
})

lsp.bashls.setup({})

lsp.dockerls.setup({})
lsp.docker_compose_language_service.setup({})

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

lsp.terraformls.setup({ capabilities = updated_capabilities })
lsp.tflint.setup({})

lsp.lua_ls.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {},
            telemetry = { enable = false },
        },
    },
})

lsp.ocamllsp.setup({
    on_attach = function(_, _)
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorHold" }, {
            callback = function() require("laurynas.lsp.codelens").refresh_virtlines() end,
        })

        vim.keymap.set(
            "n",
            "<leader>lt",
            function() require("laurynas.lsp.codelens").toggle_virtlines() end,
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

local rust_tools = require("rust-tools")

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

-- FORMATTERS
conform.setup({
    formatters_by_ft = {
        css = { "prettier" },
        astro = { {
            "prettier",
            "biome",
        } },
        dune = { "ocamllsp" },
        go = { "gofmt" },
        javascript = { {
            "prettier",
            "biome",
        } },
        lua = { "stylua" },
        nix = { "nixpkgs_fmt" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        templ = { "templ" },
        typescript = { {
            "prettier",
            "biome",
        } },
        yaml = { "yamlfmt" },
    },
})

-- MISC

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
