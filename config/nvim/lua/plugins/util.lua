return {

    -- Telescope

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",                     -- Recommended: pin to a stable release
        dependencies = {
            "nvim-lua/plenary.nvim",       -- Required dependency
            "nvim-tree/nvim-web-devicons", -- For file icons in results
            -- Optional: For better grep/live_grep performance
            -- "BurntSushi/ripgrep", -- Make sure ripgrep is installed on your system
        },
        cmd = "Telescope", -- Load only when 'Telescope' command is used
        config = function()
            local telescope = require("telescope.builtin")
            require("telescope").setup({
                defaults = {
                    -- Default options for all pickers
                    -- Example:
                    -- prompt_prefix = "  ", -- A search icon
                    selection_strategy = "closest",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal", -- "horizontal", "vertical", "flex", "center"
                    layout_config = {
                        horizontal = {
                            width = 0.9,
                            height = 0.8,
                            preview_width = 0.6,
                        },
                        vertical = {
                            width = 0.9,
                            height = 0.9,
                            preview_height = 0.6,
                        },
                        -- flex and center can be configured too
                    },
                    border = true,             -- Show border around the window
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    color_devicons = true,     -- Enable devicons in results
                    set_env = { LANG = "en" }, -- Ensure consistent language for sorting
                },
                pickers = {
                    -- Specific configurations for individual pickers
                    -- find_files = {
                    --   hidden = true,
                    --   no_ignore = false,
                    -- },
                    -- live_grep = {
                    --   theme = "dropdown",
                    -- },
                },
                extensions = {
                    -- Configure extensions here (e.g., telescope-fzf-native, telescope-project)
                },
            })

            -- Optional: Load Telescope extensions
            -- For example, if you install 'telescope-fzf-native.nvim'
            -- require('telescope').load_extension('fzf')
        end,
    },
}
