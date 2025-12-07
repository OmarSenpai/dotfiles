-- lua/plugins/mason.lua

return {
    "mason-org/mason.nvim",
    lazy = false,
    dependencies = {
        "neovim/nvim-lspconfig",
    },
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
