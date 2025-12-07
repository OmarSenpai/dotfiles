-- lua/plugins/telescope.lua

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',              -- Pin to a stable release
    dependencies = {
        'nvim-lua/plenary.nvim' -- Required dependency for Telescope
    },
    config = function()
        local builtin = require('telescope.builtin')

        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        -- remap <C-k> and <C-j> to move up and down in the list
                        ["<C-k>"] = require('telescope.actions').move_selection_previous,
                        ["<C-j>"] = require('telescope.actions').move_selection_next,
                    },
                },
            },
            -- Highlight the currently selected colorscheme in the picker instantly
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
            },
        })

        -- Keymaps for common Telescope commands
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })

        -- Theme Switcher Keymap
        vim.keymap.set('n', '<leader>c', builtin.colorscheme, { desc = '[T]heme [C]hanger' })
    end,
}
