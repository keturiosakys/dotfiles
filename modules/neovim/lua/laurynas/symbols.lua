local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")

local M = {}

local options = {
    sorting_strategy = "ascending",
}

function M.get()
    local saved_pos = vim.api.nvim_win_get_cursor(0)
    local restore_pos = function() vim.api.nvim_win_set_cursor(0, saved_pos) end

    local clients = vim.lsp.get_active_clients()

    if #clients == 0 then
        telescope_builtin.treesitter(options)
    else
        telescope_builtin.lsp_document_symbols(options)
    end
end

return M
