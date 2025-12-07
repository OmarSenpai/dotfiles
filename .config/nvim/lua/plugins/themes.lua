return {
    -- 1. Default Theme: TokyoNight
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            -- Setup function runs only once, so it sets the default theme.
            require('tokyonight').setup({
                style = 'night',
                transparent = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                },
            })
            vim.cmd.colorscheme 'tokyonight'
        end,
    },

    -- 2. Catppuccin Theme
    {
        'catppuccin/nvim',
        name = 'catppuccin',   -- required for setup
        opts = {
            flavour = 'mocha', -- Options: 'latte', 'frappe', 'macchiato', 'mocha'
            transparent_background = true,
            term_colors = true,
            styles = {
                comments = { 'italic' },
                functions = { 'bold' },
                keywords = { 'italic' },
            },
            integrations = {
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                -- Add more plugin integrations here
            },
        },
    },

    {
        "vague2k/vague.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other plugins
        config = function()
            -- NOTE: you do not need to call setup if you don't want to.
            require("vague").setup({
                transparent = false, -- don't set background
                -- disable bold/italic globally in `style`
                bold = true,
                italic = true,
                style = {
                    -- "none" is the same thing as default. But "italic" and "bold" are also valid options
                    boolean = "bold",
                    number = "none",
                    float = "none",
                    error = "bold",
                    comments = "italic",
                    conditionals = "none",
                    functions = "none",
                    headings = "bold",
                    operators = "none",
                    strings = "italic",
                    variables = "none",

                    -- keywords
                    keywords = "none",
                    keyword_return = "italic",
                    keywords_loop = "none",
                    keywords_label = "none",
                    keywords_exception = "none",

                    -- builtin
                    builtin_constants = "bold",
                    builtin_functions = "none",
                    builtin_types = "bold",
                    builtin_variables = "none",
                },
                -- plugin styles where applicable
                -- make an issue/pr if you'd like to see more styling options!
                plugins = {
                    cmp = {
                        match = "bold",
                        match_fuzzy = "bold",
                    },
                    dashboard = {
                        footer = "italic",
                    },
                    lsp = {
                        diagnostic_error = "bold",
                        diagnostic_hint = "none",
                        diagnostic_info = "italic",
                        diagnostic_ok = "none",
                        diagnostic_warn = "bold",
                    },
                    neotest = {
                        focused = "bold",
                        adapter_name = "bold",
                    },
                    telescope = {
                        match = "bold",
                    },
                },

                -- Override highlights or add new highlights
                on_highlights = function(highlights, colors) end,

                -- Override colors
                colors = {
                    bg = "#141415",
                    inactiveBg = "#1c1c24",
                    fg = "#cdcdcd",
                    floatBorder = "#878787",
                    line = "#252530",
                    comment = "#606079",
                    builtin = "#b4d4cf",
                    func = "#c48282",
                    string = "#e8b589",
                    number = "#e0a363",
                    property = "#c3c3d5",
                    constant = "#aeaed1",
                    parameter = "#bb9dbd",
                    visual = "#333738",
                    error = "#d8647e",
                    warning = "#f3be7c",
                    hint = "#7e98e8",
                    operator = "#90a0b5",
                    keyword = "#6e94b2",
                    type = "#9bb4bc",
                    search = "#405065",
                    plus = "#7fa563",
                    delta = "#f3be7c",
                },
            })
            vim.cmd("colorscheme vague")
        end
    },
}
