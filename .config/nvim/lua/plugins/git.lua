-- lua/plugins/git.lua
-- Configuration for Git integration plugins (fugitive and gitsigns).

return {
    -- 1. vim-fugitive (Git wrapper)
    {
        'tpope/vim-fugitive'
    },

    -- 2. gitsigns (Line-by-line git status)
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add          = { text = '│' },
                change       = { text = '│' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            watch_in_includes = false, -- Only track changes in files that are explicitly opened
        },
        config = function(_, opts)
            require('gitsigns').setup(opts)

            -- Keymaps for gitsigns (example: stage/unstage current line)
            vim.keymap.set('n', '<leader>gs', require('gitsigns').stage_hunk, { desc = 'Git [S]tage Hunk' })
            vim.keymap.set('n', '<leader>gu', require('gitsigns').undo_stage_hunk, { desc = 'Git [U]nstage Hunk' })
        end,
    },

    {
        "kdheepak/lazygit.nvim",
        lazy = false,
        priority = 1000,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        },
        config = function()
            vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
            vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
            vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } -- customize lazygit popup window border characters
            vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
            vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

            vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
            vim.g.lazygit_config_file_path = '' -- custom config file path
            -- OR
            vim.g.lazygit_config_file_path = {} -- table of custom config file paths
        end
    }
}
