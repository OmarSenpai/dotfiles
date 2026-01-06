-- Simple venv switcher
local M = {}

M.venvs = {
    ['System Python'] = '/usr/bin/python3',
    ['Aux Python'] = '/usr/local/bin/python3.13',
    ['Project Venv'] = vim.fn.getcwd() .. '/.venv',
    -- Add more venvs like this:
    -- ['My ML Env'] = vim.fn.expand('~/venvs/ml'),
}

M.select_venv = function()
    vim.ui.select(vim.tbl_keys(M.venvs), {
        prompt = 'Select Python Environment:',
    }, function(choice)
        if choice then
            local venv_path = M.venvs[choice]
            local python_path

            -- Check if it's a venv directory or direct python path
            if vim.fn.isdirectory(venv_path) == 1 then
                python_path = venv_path .. '/bin/python'
                vim.env.VIRTUAL_ENV = venv_path
            else
                python_path = venv_path
                vim.env.VIRTUAL_ENV = nil
            end

            -- Update all basedpyright clients
            local clients = vim.lsp.get_active_clients({ name = 'basedpyright' })
            for _, client in ipairs(clients) do
                client.config.settings.python = client.config.settings.python or {}
                client.config.settings.python.pythonPath = python_path
                client.notify('workspace/didChangeConfiguration', {
                    settings = client.config.settings
                })
            end

            print('Switched to: ' .. choice .. ' (' .. python_path .. ')')
        end
    end)
end

-- Show current Python environment
M.show_current = function()
    local venv = vim.env.VIRTUAL_ENV
    local python_path = venv and (venv .. "/bin/python") or vim.fn.exepath("python3")

    print("VIRTUAL_ENV: " .. (venv or "None"))
    print("Python path: " .. python_path)

    -- Check what LSP is using
    local clients = vim.lsp.get_active_clients({ name = "basedpyright" })
    if clients[1] and clients[1].config.settings.python then
        print("LSP using: " .. (clients[1].config.settings.python.pythonPath or "default"))
    else
        print("LSP: No basedpyright client active")
    end
end

vim.keymap.set('n', '<leader>vs', M.select_venv, { desc = 'Select Python Env' })
vim.keymap.set('n', '<leader>vp', M.show_current, { desc = 'Show Python Env' })

return M
