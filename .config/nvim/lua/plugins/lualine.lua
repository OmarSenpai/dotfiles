-- lua/plugins/lualine.lua
-- Configuration for the Lualine statusline plugin.
-- { left = '', right = '' },
-- { left = '', right = '' },

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    event = "VeryLazy",
    config = function()
        local curr_theme = vim.g.colors_name or 'auto'
        local theme_config = 'auto'

        if curr_theme == "S9npai" or curr_theme == "Midnight" then
            local curr_theme_path = "themes." .. curr_theme .. ".Xlualine"

            local ok, theme_module = pcall(require, curr_theme_path)

            if ok and theme_module and theme_module.setup then
                theme_config = theme_module.setup()
            else
                vim.notify("Failed to load custom Lualine theme for: " .. curr_theme, vim.log.levels.WARN)
            end
        end

        require("lualine").setup({
            options = {
                -- Pass the resulting theme configuration (table or 'auto')
                theme = theme_config,
                icons_enabled = true,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                globalstatus = true,
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '', right = '' }, right_padding = 2 } },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { { 'location', separator = { left = '', right = '' }, left_padding = 2 } }
            },
            inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' }
            },
            tabline = {},
            winbar = {},
            extensions = {},
        })
    end
}
