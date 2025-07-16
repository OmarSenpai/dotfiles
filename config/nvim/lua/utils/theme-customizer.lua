local M = {}

function M.apply_custom_colors(theme_name)
    -- Custom color palette
    local colors = {
        bg = "#202020",
        fg = "#f2f4f8",
        green = "#32bb97",
        orange = "#ffca61",
        yellow = "#c5c045",
        red = "#d62525",
        blue = "#548df7",
        purple = "#a976f0",
        gray = "#606060",
        lim_g = "#5a764e"
    }


    local highlights = {

        -- Basic syntax
        Normal = { bg = colors.bg, fg = colors.fg },
        Comment = { fg = colors.gray, italic = true },
        String = { fg = colors.orange },
        Character = { fg = colors.orange },
        Number = { fg = colors.yellow },
        Boolean = { fg = colors.blue },
        Float = { fg = colors.yellow },

        Function = { fg = colors.green, bold = true },
        Identifier = { fg = colors.purple },
        Statement = { fg = colors.fg },
        Keyword = { fg = colors.blue, bold = true },
        Operator = { fg = colors.fg },
        Type = { fg = colors.purple, bold = true },
        Constant = { fg = colors.purple },

        -- Tree-sitter overrides
        ["@string"] = { fg = colors.orange },
        ["@keyword"] = { fg = colors.blue },
        ["@type"] = { fg = colors.purple, bold = true },
        ["@tag"] = { fg = colors.red },
        ["@number"] = { fg = colors.yellow },
        ["@variable"] = { fg = colors.fg },
        ["@parameter"] = { fg = colors.fg },
        ["@field"] = { fg = colors.purple },
        ["@property"] = { fg = colors.purple },
        ["@method"] = { fg = colors.green, bold = true },
        ["@namespace"] = { fg = colors.blue },
        ["@constructor"] = { fg = colors.green },
        ["@lsp.type.function"] = { fg = colors.green, bold = true },
        ["@lsp.type.method"] = { fg = colors.green, bold = true },
        ["@lsp.type.function.call"] = { fg = colors.green, bold = true },
        ["@lsp.type.method.call"] = { fg = colors.green, bold = true },
        ["@lsp.mod.declaration"] = { fg = colors.green, bold = true },
        ["@lsp.mod.definition"] = { fg = colors.green, bold = true },
    }

    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end

    M.highlights = highlights

    vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = theme_name,
        callback = function()
            -- Reapply highlights after colorscheme loads
            vim.schedule(function()
                for group, opts in pairs(highlights) do
                    vim.api.nvim_set_hl(0, group, opts)
                end
            end)
        end,
    })
end

-- Setup hot reload autocmd
function M.setup_hot_reload()
    -- Get the path to this file
    local config_path = vim.fn.stdpath("config")
    local theme_customizer_path = config_path .. "/lua/utils/theme-customizer.lua"

    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = theme_customizer_path,
        callback = function()
            M.reload()
        end,
        desc = "Hot reload theme customizer on save"
    })

    -- Also create a command for manual reload
    vim.api.nvim_create_user_command("Reloadtheme", function()
        M.reload()
    end, { desc = "Manually reload theme customizer" })

    print("Theme customizer hot reload enabled")
end

-- Hot reload function
function M.reload()
    -- Clear the module from package.loaded
    package.loaded['utils.theme-customizer'] = nil

    -- Re-require the module
    local reloaded = require('utils.theme-customizer')

    -- Reapply colors if we have a current theme
    if M.current_theme then
        reloaded.apply_custom_colors(M.current_theme)
        print("Theme customizer reloaded and applied to: " .. M.current_theme)
    else
        print("Theme customizer reloaded (no theme to reapply)")
    end

    return reloaded
end

return M
