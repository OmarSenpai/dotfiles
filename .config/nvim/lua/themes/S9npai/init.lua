-- Main setup function that applies all highlights
local M = {}

M.setup = function()
    vim.opt.termguicolors = true
    vim.g.colors_name = "S9npai"

    -- Get the highlight groups from groups.lua
    local ok, groups_module = pcall(require, "themes.S9npai.groups")
    if not ok then
        vim.notify("Failed to load S9npai.groups: " .. tostring(groups_module), vim.log.levels.ERROR)
        return
    end

    local groups = groups_module.setup()

    -- Apply each highlight group
    for group, settings in pairs(groups) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

return M
