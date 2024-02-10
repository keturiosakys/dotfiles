local telescope = require("telescope")
local builtins = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

-- function M.get()
--     local saved_pos = vim.api.nvim_win_get_cursor(0)
--     local restore_pos = function() vim.api.nvim_win_set_cursor(0, saved_pos) end
--
--     local clients = vim.lsp.buf_get_clients()
--
--     local options = {
--         sorting_strategy = "ascending",
--         attach_mappings = function(prompt_bufnr, map)
--             local move_selection_change = function(direction)
--                 return function()
--                     actions["move_selection_" .. direction](prompt_bufnr)
--                     local selection = action_state.get_selected_entry()
--                     if selection then
--                         -- Calculate the buffer number and cursor position for the selection
--                         local cursor_pos = { selection.lnum, selection.col }
--                         -- Scroll the buffer to the selection
--                         vim.api.nvim_win_set_cursor(0, cursor_pos)
--                     end
--                 end
--             end
--
--             map("i", "<C-n>", move_selection_change("next"))
--             map("i", "<C-p>", move_selection_change("previous"))
--
--             -- Override <esc> to restore the original position and close Telescope
--             map("i", "<esc>", function()
--                 restore_pos()
--                 actions.close(prompt_bufnr)
--             end)
--
--             -- Ensure default selection behavior on Enter
--             actions.select_default:replace(function() actions.close(prompt_bufnr) end)
--
--             return true
--         end,
--     }
--
--     if #clients == 0 then
--         builtins.treesitter(options)
--         return
--     end
--
--     for _, client in ipairs(clients) do
--         if client.server_capabilities.documentSymbolProvider then
--             builtins.lsp_document_symbols(options)
--             return
--         else
--             builtins.treesitter(options)
--         end
--     end
-- end

function M.get()
    local clients = vim.lsp.buf_get_clients()

    local options = {
        sorting_strategy = "ascending",
        prompt_position = "top",
    }

    if #clients == 0 then
        builtins.treesitter(options)
        return
    end

    for _, client in ipairs(clients) do
        if client.server_capabilities.documentSymbolProvider then
            builtins.lsp_document_symbols(options)
            return
        else
            builtins.treesitter(options)
        end
    end
end

return M
