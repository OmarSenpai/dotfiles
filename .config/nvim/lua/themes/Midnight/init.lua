-- Main setup function that applies all highlights
local M = {}

M.setup = function()
    vim.opt.termguicolors = true

    -- Get the highlight groups from groups.lua
    local ok, groups_module = pcall(require, "themes.Midnight.groups")
    if not ok then
        vim.notify("Failed to load Midnight.groups: " .. tostring(groups_module), vim.log.levels.ERROR)
        return
    end

    local groups = groups_module.setup()

    -- Apply each highlight group
    for group, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

return M
