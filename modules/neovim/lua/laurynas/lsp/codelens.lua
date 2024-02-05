-- Straight up ripped from:
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/lsp/codelens.lua

local M = {}

local virtlines_enabled = true

M.toggle_virtlines = function()
    virtlines_enabled = not virtlines_enabled
    M.refresh_virtlines()
end

M.refresh_virtlines = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local params = { textDocument = vim.lsp.util.make_text_document_params() }

    vim.lsp.buf_request(
        bufnr,
        "textDocument/codeLens",
        params,
        function(err, result, _, _)
            if err then return end

            local ns = vim.api.nvim_create_namespace("custom-lsp-codelens")
            vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

            if not virtlines_enabled then return end

            for _, lens in ipairs(result) do
                local title = lens.command.title
                local range = lens.range
                local prefix = string.rep(" ", lens.range.start.character)
                local text = prefix .. title

                local lines = { { { text, "VirtNonText" } } }
                if string.len(text) > 100 then
                    vim.g.something = true
                    lines = {}

                    local split_text = vim.split(text, "->")
                    for i, line in ipairs(split_text) do
                        if i ~= #split_text then line = line .. " ->" end

                        table.insert(lines, { { line, "VirtNonText" } })
                    end
                end

                vim.api.nvim_buf_set_extmark(bufnr, ns, range.start.line, 0, {
                    virt_lines_above = true,
                    virt_lines = lines,
                })
            end
        end
    )
end

return M
