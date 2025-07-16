-- lua/plugins/debug.lua
return {

    {
        "nvim-neotest/nvim-nio",
    },

    -- Main DAP plugin
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-telescope/telescope-dap.nvim',
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            -- Setup DAP UI
            dapui.setup()

            -- Auto-open/close UI
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end

            -- Key mappings
            vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
            vim.keymap.set('n', '<F8>', dap.step_over, { desc = 'Debug: Step Over' })
            vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debug: Step Into' })
            vim.keymap.set('n', '<S-F8>', dap.step_out, { desc = 'Debug: Step Out' })
            vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
            vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Debug: Open REPL' })
            vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run Last' })
        end,
    },

    -- Mason integration for debug adapters
    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'mfussenegger/nvim-dap',
        },
        config = function()
            require('mason-nvim-dap').setup({
                automatic_setup = true,
                handlers = {},
            })
        end,
    },
}
