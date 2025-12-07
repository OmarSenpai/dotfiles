return {
    "akinsho/toggleterm.nvim",
    version = '*',
    cmd = 'ToggleTerm',

    keys = {
        -- Existing keymaps
        { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Toggle Vertical Terminal" },
        { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Horizontal Terminal" },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",      desc = "Toggle Floating Terminal" },
        { "<leader>tt", "<cmd>ToggleTerm<cr>",                      desc = "Toggle Terminal" },
        { "<leader>g",  "<cmd>lua _LAZYGIT_TOGGLE()<cr>",           desc = "Toggle Lazygit" },
    },

    config = function(_, opts)
        require("toggleterm").setup(opts)

        local Terminal = require("toggleterm.terminal").Terminal

        local lazygit_term = Terminal:new({
            cmd = "lazygit",
            name = "lazygit",
            direction = "float",
            start_in_insert = false,
            insert_mappings = false,
        })

        _LAZYGIT_TOGGLE = function()
            lazygit_term:toggle()
        end
    end,

    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                -- Default to 40% of columns if direction is vertical
                return vim.o.columns * 0.4
            else
                return 20 -- Default size for float/tab
            end
        end,

        hide_numbers = true,
        shade_filetypes = {},
        autochdir = false,
        open_mapping = false,

        shade_terminals = true,
        shading_factor = -30,
        shading_ratio = -3,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = 'vertical',
        close_on_exit = true,
        clear_env = false,
        shell = vim.o.shell,
        auto_scroll = true,

        -- This field is only relevant if direction is set to 'float'
        float_opts = {
            border = 'single',    -- Default border style
            width = 128,          -- Your specified width
            height = 32,          -- Your specified height
            winblend = 3,
            title_pos = 'center', -- Default position
        },
        winbar = {
            enabled = false,
            name_formatter = function(term)
                return term.name
            end
        },
        responsiveness = {
            horizontal_breakpoint = 135,
        }
    }
}
