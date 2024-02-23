local function macro_mode()
    local rec_register = vim.fn.reg_recording()
    if rec_register == "" then
        return ""
    else
        return "REC @" .. rec_register
    end
end

local options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = " ", right = " " },
    section_separators = { left = " ", right = " " },
    disabled_filetypes = {
        statusline = {},
        winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
        statusline = 500,
        tabline = 1000,
        winbar = 1000,
    },
}

local clients = function()
    local clients = vim.lsp.get_active_clients()
    local client_names = {}
    for _, client in pairs(clients) do
        if client.name ~= "null-ls" then table.insert(client_names, client.name) end
    end
    return table.concat(client_names, ", ")
end

local lsp = function() return clients() end

local sections = {
    lualine_a = { "mode" },
    lualine_b = {
        -- { "branch", icon = "" },
        { "branch" },
        {
            "diagnostics",
            symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
        },
    },
    lualine_c = {
        {
            "filename",
            newfile_status = true,
            path = 1,
        },
        macro_mode,
    },
    lualine_x = {
        lsp,
        {
            "diff",
            colored = false, -- Displays a colored diff status if set to true
        },
        "filetype",
    },
    lualine_y = {},
    lualine_z = { "location" },
}

local tabline = {
    lualine_a = {
        {
            "tabs",
            mode = 2,
        },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
}

local winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
        {
            "aerial",
        },
    },
    lualine_x = { "filename" },
    lualine_y = {},
    lualine_z = {},
}

local inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "filename" },
    lualine_y = {},
    lualine_z = {},
}

require("lualine").setup({
    options = options,
    sections = sections,
    -- tabline = tabline,
    winbar = winbar,
    inactive_winbar = inactive_winbar,
})

require("fidget").setup()
