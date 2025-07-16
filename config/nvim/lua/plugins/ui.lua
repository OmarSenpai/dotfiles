return {
    -----------------------------------------------------------------------------
    --  Lua line
    -----------------------------------------------------------------------------
    {
        "nvim-lualine/lualine.nvim",
        lazy = false, -- Status line should be available immediately
        -- Ensure devicons are loaded if you want icons in your status line
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { -- Use the 'opts' table to pass configuration directly to lualine's setup()
            options = {
                icons_enabled = true, -- Enable showing file/folder icons
                theme = "auto", -- Use an auto-detected theme, or specify 'tokyonight' for consistency
                -- Component and section separators define the visual style of your status line
                component_separators = { left = "", right = "" }, -- UTF-8 triangles for separation
                section_separators = { left = "", right = "" }, -- UTF-8 triangles for sections
                disabled_filetypes = { -- Filetypes where Lualine should be disabled
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},                                    -- Filetypes where Lualine ignores window focus
                always_last_status = true,                            -- Always show statusline in the last window
                padding = 1,                                          -- Padding around components
            },
            sections = {                                              -- Define what content goes into each section of the active status line
                lualine_a = { "mode" },                               -- Mode (NORMAL, INSERT, VISUAL, etc.)
                lualine_b = { "branch", "diff", "diagnostics" },      -- Git branch, Git diff changes, LSP diagnostics (errors, warnings)
                lualine_c = { { "filename", path = 1 } },             -- Current filename, with path=1 to show relative path
                lualine_x = { "encoding", "fileformat", "filetype" }, -- File encoding, format (unix/dos), and type
                lualine_y = { "progress" },                           -- Percentage of file scrolled
                lualine_z = { "location" },                           -- Current line and column number
            },
            inactive_sections = {                                     -- Define what content goes into each section of inactive status lines
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "filename", path = 1 } }, -- Only filename for inactive windows
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},    -- Set to {} to disable, or configure a tabline for buffers
            extensions = {}, -- Add Lualine extensions here if needed (e.g., 'nvim-tree', 'lazy')
        },
    },


    -----------------------------------------------------------------------------
    --  Bufferline
    -----------------------------------------------------------------------------
    {
        "akinsho/bufferline.nvim",
        event = "BufReadPost",                            -- Load after a buffer is read
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- For icons in the bufferline
        config = function()
            require("bufferline").setup({
                options = {
                    -- General options
                    mode = "tabs",       -- or "buffers" or "quick_links"
                    themable = true,
                    numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "filename" | function
                    -- separator_style = "slant", -- "slant" | "padded_slant" | "rounded" | "default" | "thin" | function
                    -- The separator_style below is often preferred for a cleaner look
                    separator_style = {
                        { "", "" }, -- No separator between buffer names for a sleek look
                        { "", "" },
                    },
                    always_show_bufferline = true,
                    max_name_length = 18,
                    max_filename_length = 14,
                    cont_trunc_where = "middle", -- "start" | "middle" | "end"
                    color_icons = true,          -- Disable if you don't want color icons
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    enforce_regular_tabs = true,
                    sort_by = "insert_after_current", -- "id" | "extension" | "relative_directory" | "tabs" | function(bufferA, bufferB)

                    -- Padding around buffer names
                    padding = 0,
                    right_mouse_command = "BufferLineCloseRight", -- Command when right-clicking on a buffer

                    -- Indicators
                    indicators = {
                        buffer_close_icon = "", -- A cross icon for closing buffers
                        -- tab_manager = "", -- Icon for the tab manager (if you use mode = "tabs")
                        -- mouse_selected_icon = "",
                        -- modified = "●",
                    },

                    -- Animation (requires 'gooly/animation.nvim' - optional)
                    -- animation = {
                    --   enabled = true,
                    --   duration = 200,
                    -- },

                    -- Custom Sections (advanced)
                    -- sections = {
                    --   left = { 'buffers' },
                    --   middle = {},
                    --   right = { 'diagnostics', 'gitsigns' },
                    -- },
                },
                -- Customize styling based on highlight groups (optional)
                -- highlights = {
                --   buffer_selected = {
                --     fg = {attribute="fg", highlight="Function"},
                --     bold = true,
                --   },
                -- },
            })
        end,
    }
}
