return {
    -----------------------------------------------------------------------------
    --  Nvimtree File Explorer & icons
    -----------------------------------------------------------------------------

    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
        opts = {},
    },


    {
        "nvim-tree/nvim-tree.lua",
        cmd = "NvimTreeToggle",

        dependencies = { "nvim-tree/nvim-web-devicons" },

        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 45,            --tree width
                    relativenumber = true, -- =relative line numbers
                    disable_netrw = true
                },

                renderer = {
                    group_empty = true,
                    highlight_git = true,
                    icons = {
                        git_placement = "before", --git icons before filename
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true
                        },
                    },
                },

                filters = {
                    dotfiles = true, --show dotfiles
                },

                git = {
                    ignore = false,
                    custom = {},
                },

                actions = {
                    open_file = {
                        quit_on_open = false,
                        no_window_picker = false
                    },
                },

                -- Set Nvimtree keymaps
                on_attach = function(bufnr)
                    local api = require("nvim-tree.api")

                    local function opts(desc)
                        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                    end

                    -- The line for defining default mappings (api.nvim_tree_keys.define_mappings) is no longer valid
                    -- and has been removed/deprecated in newer nvim-tree versions.
                    -- If you need specific default mappings, you'd typically define them
                    -- in the `actions` table within the nvim-tree.setup() itself,
                    -- or explicitly map them here like your custom ones below.

                    -- Custom mappings using the current nvim-tree.api
                    -- These are generally more stable across updates.
                    -- Always refer to `:h nvim-tree.api` for the very latest API if these ever break again.

                    -- NvimTree Toggle (this is defined in keymaps.lua, but showing here for completeness if you wanted it here)
                    -- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

                    -- 'h': Go to parent directory
                    vim.keymap.set("n", "h", function()
                        api.tree.change_root("..")
                    end, opts("Go to parent directory"))

                    -- '<CR>': Change root to the selected node (enter folder subtree)
                    vim.keymap.set("n", "<CR>", api.tree.change_root_to_node, opts("Change root to node"))

                    -- 'l': Open file / expand directory
                    vim.keymap.set("n", "l", api.node.open.edit, opts("Open file"))

                    -- 'K': Previous sibling
                    vim.keymap.set("n", "K", api.node.navigate.sibling.prev, opts("Previous Sibling"))

                    -- 'J': Next sibling
                    vim.keymap.set("n", "J", api.node.navigate.sibling.next, opts("Next Sibling"))
                end,
            })
        end,
    },


    -----------------------------------------------------------------------------
    --  Theme
    -----------------------------------------------------------------------------

    -- Colorscheme for syntax highlighting and overall look
    {
        "catppuccin/nvim",
        name = "catppuccin", -- Important for lazy.nvim to find it by name
        lazy = false,        -- Must be loaded immediately
        priority = 1000,     -- High priority to ensure it loads first
        config = function()
            require("catppuccin").setup({
                -- You can choose one of the 'flavour' options: 'mocha', 'macchiato', 'frappe', 'latte'
                flavour = "macchiato",         -- This is the darkest one, similar to the image
                transparent_background = true, -- <--- Set this to true for transparency!
                term_colors = true,            -- Apply Catppuccin colors to your terminal
                dim_inactive = {               -- Dim inactive windows for better focus
                    enabled = false,
                    shade = 0.6,
                    percentage = 0.7,
                },
                styles = { -- Customize styles for various elements
                    comments = { "italic" },
                    functions = { "bold" },
                    keywords = { "bold" },
                    strings = {},
                    variables = {},
                },
                integrations = { -- Integrations with other plugins
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    bufferline = true,
                    telescope = {
                        enabled = true,
                        native = false -- For Telescope's built-in themes
                    },
                    -- Lualine often picks up the colorscheme automatically,
                    -- but you can enable this for explicit integration
                    -- You can add more integrations as you add plugins
                },
                -- Customize specific highlight groups if needed
                -- custom_highlights = function(colors)
                --   return {
                --     LineNr = { fg = colors.surface0 }, -- Example: slightly lighter line numbers
                --   }
                -- end,
            })
            -- Set the colorscheme
            vim.cmd.colorscheme "catppuccin"
        end,
    },

    -- Nightfox Theme
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        config = function()
            require("nightfox").setup({
                options = {
                    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
                    compile_file_suffix = "_compiled", -- Compiled file suffix
                    transparent = true,                -- Disable setting background
                    terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                    dim_inactive = false,              -- Non focused panes set to alternative background
                    module_default = true,             -- Default enable value for modules
                    colorblind = {
                        enable = false,                -- Enable colorblind support
                        simulate_only = false,         -- Only show simulated colorblind colors and not diff shifted
                        severity = {
                            protan = 0,                -- Severity [0,1] for protan (red)
                            deutan = 0,                -- Severity [0,1] for deutan (green)
                            tritan = 0,                -- Severity [0,1] for tritan (blue)
                        },
                    },

                    styles = {               -- Style to be applied to different syntax groups
                        comments = "italic", -- Value is any valid attr-list value `:help attr-list`
                        conditionals = "bold",
                        constants = "NONE",
                        functions = "bold",
                        keywords = "bold",
                        numbers = "NONE",
                        operators = "NONE",
                        strings = "NONE",
                        types = "NONE",
                        variables = "NONE",
                    },

                    inverse = { -- Inverse highlight for different types
                        match_paren = false,
                        visual = false,
                        search = false,
                    },

                    modules = { -- List of various plugins and additional options
                        cmp = true,
                        gitsigns = true,
                        nvimtree = true,
                        telescope = true,
                        -- ... add more modules as needed
                    },
                },
                palettes = {},
                specs = {},
                groups = {},
            })

            vim.cmd.colorscheme "carbonfox"
            local cstmz = require('utils.theme-customizer')
            cstmz.apply_custom_colors("carbonfox")
            cstmz.setup_hot_reload()
        end,
    },

    -- Kanagawa theme
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        config = function()
            require('kanagawa').setup({
                compile = false,  -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = { bold = true },
                keywordStyle = { bold = true },
                statementStyle = {},
                typeStyle = { bold = true },
                transparent = false,   -- do not set background color
                dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                colors = {             -- add/modify theme and palette colors
                    palette = {},
                    theme = {
                        wave = {}, lotus = {}, dragon = {}, all = {}
                    },
                },
                overrides = function(colors) -- add/modify highlights
                    return {}
                end,
                theme = "wave",    -- Load "wave" theme
                background = {     -- map the value of 'background' option to a theme
                    dark = "wave", -- try "dragon" !
                    light = "lotus"
                },
            })
        end,
    },

    -- oxocarbon theme
    {
        "nyoom-engineering/oxocarbon.nvim",
        config = function()
            vim.cmd.colorscheme "oxocarbon"
        end
    },

    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            options = {
                theme = "catppuccin",
                separator_style = "slant",
            }
        }
    },

    -- Theme switcher plugin
    {
        "zaldih/themery.nvim",
        lazy = false,
        config = function()
            require("themery").setup({
                themes = {
                    "catppuccin",
                    "catppuccin-latte",
                    "catppuccin-frappe",
                    "catppuccin-macchiato",
                    "catppuccin-mocha",
                    "nightfox",
                    "dayfox",
                    "dawnfox",
                    "duskfox",
                    "nordfox",
                    "terafox",
                    "carbonfox",
                    "kanagawa-wave",
                    "kanagawa-dragon",
                    "kanagawa-lotus",
                    "oxocarbon"
                },
                livePreview = true,
            })
        end
    },

    vim.keymap.set("n", "<leader>t", ":Themery<CR>", { desc = "Theme switcher" }),
    vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" }),
    vim.keymap.set("n", "<C-y>", "<C-r>", { desc = "Redo" }),

    -- Insert mode undo/redo
    vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode" }),
    vim.keymap.set("i", "<C-y>", "<C-o><C-r>", { desc = "Redo in insert mode" }),

    -- Save file
    vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" }),
    vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" }),
    vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save in insert mode" }),
    vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>", { desc = "Save in visual mode" })
}
