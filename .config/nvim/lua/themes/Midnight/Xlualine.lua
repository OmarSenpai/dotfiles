local M = {}
M.setup = function()
    local c = require("themes.Midnight.palette")
    return {
        normal = {
            a = { fg = c.bg0, bg = c.light_mint, gui = "bold" },
            b = { fg = c.fg1, bg = c.surface },
            c = { fg = c.fg_muted, bg = c.bg_dark },
        },
        insert = {
            a = { fg = c.bg0, bg = c.green, gui = "bold" },
            b = { fg = c.fg1, bg = c.surface },
            c = { fg = c.fg_muted, bg = c.bg_dark },
        },
        visual = {
            a = { fg = c.bg0, bg = c.light_purple, gui = "bold" },
            b = { fg = c.fg1, bg = c.surface },
            c = { fg = c.fg_muted, bg = c.bg_dark },
        },
        replace = {
            a = { fg = c.bg0, bg = c.pink, gui = "bold" },
            b = { fg = c.fg1, bg = c.surface },
            c = { fg = c.fg_muted, bg = c.bg_dark },
        },
        command = {
            a = { fg = c.bg0, bg = c.orange, gui = "bold" },
            b = { fg = c.fg1, bg = c.surface },
            c = { fg = c.fg_muted, bg = c.bg_dark },
        },
        inactive = {
            a = { fg = c.fg_muted, bg = c.bg_darker },
            b = { fg = c.fg_muted, bg = c.bg_darker },
            c = { fg = c.fg_muted, bg = c.bg_darker },
        }
    }
end

return M
