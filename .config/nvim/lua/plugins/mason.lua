-- lua/plugins/mason.lua

return {
    "mason-org/mason.nvim", -- Fixed: correct plugin name (was mason-org/mason.nvim)
    lazy = false,
    priority = 1000,
    config = function()
        local mason = require("mason")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "⟳",
                    package_uninstalled = "✗",
                },
            },
        })
    end,
}
