-- lua/plugins/neotree.lua
return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    lazy = false,
    priority = 1000,
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- Required for icons
        'MunifTanjim/nui.nvim',        -- Required UI library
    },
    cmd = 'Neotree',                   -- Lazy-load on Neotree command
    config = function()
        require('neo-tree').setup({
            popup_border_style = 'rounded',
            close_if_last_window = true, -- Close Neovim if file explorer is the last window left

            window = {
                mappings = {
                    -- NEW KEYMAPS BELOW
                    ['<CR>'] = 'open',                  -- Open file/folder, using window picker
                    ['r'] = 'set_root',                 -- 'c'hange 'd'irectory (set selected folder as root)
                    ['<BS>'] = 'prev_root',             -- 'B'ack'S'pace (go to previous root/parent directory)
                    ['<F2>'] = 'rename',                -- 'r'ename selected file/folder
                    ['<C-h>'] = 'toggle_hidden',        -- toggle 'h'idden items
                    ['<C-c>'] = 'copy_to_clipboard',    -- 'Ctrl + C' Mark file/folder for COPY
                    ['<C-x>'] = 'cut_to_clipboard',     -- 'Ctrl + X' Mark file/folder for CUT (move)
                    ['<C-v>'] = 'paste_from_clipboard', -- 'Ctrl + V' Mark file/folder for PASTE
                    ['<A>'] = 'create_directory',
                    ['<a>'] = 'create_file',
                    ['Del'] = 'delete'
                },
            },

            filesystem = {
                filtered_items = {
                    visible = true, -- Show filtered items in the tree
                    hide_dotfiles = true,
                    hide_gitignored = false,
                    never_show = {
                        'thumbs.db',
                        '.DS_Store',
                        'package-lock.json',
                    },
                },
            },
        })

        -- Keymap to toggle Neo-tree
        vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = '[E]xplore Project' })
        vim.opt.fillchars = { vert = '┃' }
    end,
}
