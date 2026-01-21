-- lua/plugins/lspconfig.lua
return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "williamboman/mason.nvim", -- Fixed namespace to official williamboman
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "folke/neodev.nvim",
        "ray-x/lsp_signature.nvim",
    },

    event = { "BufReadPre", "BufNewFile" },

    config = function()
        local lspconfig = require("lspconfig")
        local cmp = require("cmp_nvim_lsp")

        local capabilities = cmp.default_capabilities()

        local on_attach = function(client, bufnr)
            local map = vim.keymap.set
            local opts = { buffer = bufnr, silent = true }

            map("n", "gd", vim.lsp.buf.definition, opts)
            map("n", "K", vim.lsp.buf.hover, opts)
            map("n", "<leader>rn", vim.lsp.buf.rename, opts)
            map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end

        require("neodev").setup({})

        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "lua_ls",
                "gopls",
            },

            handlers = {
                -- The default handler
                function(server)
                    lspconfig[server].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = {
                            Lua = {
                                diagnostics = { globals = { "vim" } },
                                workspace = { checkThirdParty = false },
                            },
                        },
                    })
                end,

                ["gopls"] = function()
                    lspconfig.gopls.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        root_dir = function(fname)
                            -- This allows gopls to work in your Katana-Shell project
                            -- even without a go.mod file
                            return lspconfig.util.root_pattern("go.mod", ".git")(fname) or vim.loop.cwd()
                        end,
                        settings = {
                            gopls = {
                                ["ui.completion.usePlaceholders"] = true,
                                ["build.experimentalWorkspaceModule"] = true,
                            },
                        },
                    })
                end,
            }
        })


        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function(args)
                local bufnr = args.buf
                if not next(vim.lsp.get_clients({ bufnr = bufnr })) then
                    vim.defer_fn(function()
                        pcall(vim.cmd.LspStart)
                    end, 50)
                end
            end,
        })
    end,
}
