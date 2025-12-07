-- lua/plugins/lspconfig.lua
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "folke/neodev.nvim",
        "mason-org/mason-lspconfig.nvim",
        "ray-x/lsp_signature.nvim",
    },

    -- earlier load to avoid race with buffer open
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local capabilities = cmp_nvim_lsp.default_capabilities()

        local on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            local map = vim.keymap.set

            map("n", "gd", vim.lsp.buf.definition, opts)
            map("n", "gD", vim.lsp.buf.declaration, opts)
            map("n", "gi", vim.lsp.buf.implementation, opts)
            map("n", "K", vim.lsp.buf.hover, opts)
            map("n", "<leader>e", vim.diagnostic.open_float, opts)
            map("n", "[d", vim.diagnostic.goto_prev, opts)
            map("n", "]d", vim.diagnostic.goto_next, opts)
            map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP Code Action" })
            map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP Rename" })
            map("n", "gr", vim.lsp.buf.references, opts)
            map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end,
                { buffer = bufnr, desc = "LSP Format File" })
            map("n", "<leader>lr", vim.lsp.buf.restart, { buffer = bufnr, desc = "LSP Restart" })

            -- highlight symbol under cursor
            if client.server_capabilities.documentHighlightProvider then
                local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
                vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    group = group, buffer = bufnr, callback = vim.lsp.buf.document_highlight,
                })
                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                    group = group, buffer = bufnr, callback = vim.lsp.buf.clear_references,
                })
            end
        end

        require("mason").setup() -- ⬅ explicitly start Mason first
        require("neodev").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = { "clangd", "gopls", "lua_ls", "jdtls" },
            handlers = {
                -- default handler
                function(server_name)
                    lspconfig[server_name].setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                    })
                end,


                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = { globals = { "vim" } },
                                workspace = {
                                    checkThirdParty = false,
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                                telemetry = { enable = false },
                            },
                        },
                    })
                end,

                ["jdtls"] = function()
                    lspconfig.jdtls.setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                    })
                end,
            },
        })

        require("lsp_signature").setup({
            bind = true,
            handler_opts = { border = "rounded" },
            hint_enable = false,
        })

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Fallback: ensure LSP attached even if lazy race occurred
        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function(args)
                local bufnr = args.buf
                local active = vim.lsp.get_active_clients({ bufnr = bufnr })
                if not next(active) then
                    vim.schedule(function() pcall(vim.cmd.LspStart) end)
                end
            end,
        })
    end,
}
