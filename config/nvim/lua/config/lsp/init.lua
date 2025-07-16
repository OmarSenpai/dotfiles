-- config/lsp/init.lua
-- Fixed LSP configuration for proper autocompletion and hover

local mason = require("mason")
local lspconfig = require("lspconfig")

-- Setup Mason
mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Enhanced LSP keybindings and features
local function on_attach(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "<C-h>", vim.lsp.buf.hover, opts)

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

    -- Documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)

    -- FIXED: Add insert mode signature help (non-conflicting)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

    -- Code actions
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, opts)

    -- Diagnostics
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

    -- Workspace management
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- REMOVED: Automatic hover on CursorHold - this interferes with completion
    -- Instead, we'll rely on manual hover with K or <C-h> in insert mode


    -- Highlight symbol under cursor - Only in normal mode
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
        vim.api.nvim_create_autocmd("CursorHold", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = function()
                if vim.api.nvim_get_mode().mode == 'n' then
                    vim.lsp.buf.document_highlight()
                end
            end,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    -- Show LSP info for current buffer
    print("✓ LSP attached: " .. client.name .. " to " .. vim.api.nvim_buf_get_name(bufnr))
end

-- FIXED: Enhanced capabilities with proper nvim-cmp integration
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Properly integrate with nvim-cmp
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    print("✓ nvim-cmp capabilities integrated")
else
    print("⚠ nvim-cmp not found - completion may not work properly")
end

-- FIXED: Enhanced capabilities for better completion
capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

-- FIXED: Better hover support
capabilities.textDocument.hover = {
    dynamicRegistration = true,
    contentFormat = { "markdown", "plaintext" }
}

-- FIXED: Enable signature help
capabilities.textDocument.signatureHelp = {
    dynamicRegistration = true,
    signatureInformation = {
        documentationFormat = { "markdown", "plaintext" },
        parameterInformation = {
            labelOffsetSupport = true
        }
    }
}

-- Helper function to setup servers with enhanced configuration
local function setup_server(server_name, config)
    config = config or {}
    config.on_attach = on_attach
    config.capabilities = capabilities

    -- Add single file support for all servers
    config.single_file_support = true

    -- Add root directory detection
    if not config.root_dir then
        config.root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern(".git", "package.json", "Cargo.toml", "go.mod", "pyproject.toml", "Makefile")(fname)
                or util.path.dirname(fname)
        end
    end

    local ok, err = pcall(function()
        lspconfig[server_name].setup(config)
    end)

    if ok then
        print("✓ " .. server_name .. " configured")
    else
        vim.notify("✗ Failed to setup " .. server_name .. ": " .. tostring(err), vim.log.levels.WARN)
    end
end

-- FIXED: TypeScript/JavaScript with proper completion settings
setup_server("ts_ls", {
    filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    settings = {
        typescript = {
            preferences = {
                disableSuggestions = false,
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                includeCompletionsWithInsertText = true,
            },
            suggest = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
            }
        },
        javascript = {
            preferences = {
                disableSuggestions = false,
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                includeCompletionsWithInsertText = true,
            },
            suggest = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
            }
        }
    }
})

-- Rest of your server configurations...
setup_server("eslint", {
    settings = {
        workingDirectory = { mode = "auto" }
    },
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
})

setup_server("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--cross-file-rename",
        "--header-insertion=iwyu",
        "--function-arg-placeholders",
        "--fallback-style=llvm"
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
    },
})

setup_server("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
            },
            checkOnSave = {
                command = "clippy",
                allFeatures = true,
            },
            procMacro = {
                enable = true,
            },
            completion = {
                addCallParentheses = false,
                addCallArgumentSnippets = true,
            },
        }
    }
})

setup_server("pyright", {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
            }
        }
    }
})

setup_server("gopls", {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        }
    }
})

setup_server("jdtls")
setup_server("html")
setup_server("cssls")
setup_server("jsonls")
setup_server("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        }
    }
})

setup_server("cmake")
setup_server("bashls")
setup_server("yamlls")

-- FIXED: Enhanced diagnostic configuration
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        source = "if_many",
        spacing = 2,
    },
    signs = true,
    underline = true,
    update_in_insert = false, -- Don't update diagnostics in insert mode
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        focusable = true,
        header = "",
        prefix = "",
        suffix = "",
    },
})

-- Enhanced diagnostic signs
local signs = {
    Error = "󰅚 ",
    Warn = "󰀪 ",
    Hint = "󰌶 ",
    Info = " "
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- FIXED: Enhanced LSP handlers with better UI
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    focusable = false,
    relative = "cursor",
    title = " Hover ",
    max_width = 80,
    max_height = 20,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    focusable = true,
    relative = "cursor",
    title = " Signature Help ",
})

-- FIXED: Better completion configuration
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- FIXED: Set reasonable updatetime for better experience
vim.opt.updatetime = 400

-- FIXED: Ensure completion triggers properly
vim.opt.shortmess:append "c" -- Don't show completion messages

-- Auto-format on save for supported languages
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go", "*.rs", "*.lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-- ADDED: Force completion to show in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        -- Ensure completion is enabled
        vim.opt_local.completeopt = { "menu", "menuone", "noselect" }
        -- Clear any conflicting autocmds
        vim.api.nvim_clear_autocmds({ group = "lsp_document_highlight", buffer = 0 })
    end,
})

print("🚀 Fixed LSP configuration loaded!")
print("💡 Completion should now work properly in insert mode")
print("🔧 Use :Mason to install language servers")
print("🎯 Try typing and see autocompletion appear!")
print("📋 Use <C-h> in insert mode for hover info")
print("🔍 Use <C-k> in insert mode for signature help")

-- Show current LSP status
vim.api.nvim_create_user_command("LspStatus", function()
    local clients = vim.lsp.get_active_clients()
    if #clients == 0 then
        print("No LSP clients active")
    else
        print("Active LSP clients:")
        for _, client in pairs(clients) do
            print("  - " .. client.name .. " (ID: " .. client.id .. ")")
        end
    end
end, {})

-- ADDED: Debug completion command
vim.api.nvim_create_user_command("CmpDebug", function()
    local has_cmp, cmp = pcall(require, "cmp")
    if not has_cmp then
        print("CMP not found!")
        return
    end

    print("CMP Status:")
    print("  Visible: " .. tostring(cmp.visible()))
    print("  Available: " .. tostring(cmp.get_active_clients and #cmp.get_active_clients() or "unknown"))
    print("  Sources: " .. vim.inspect(cmp.get_config().sources))
    print("  Capabilities: " .. vim.inspect(capabilities.textDocument.completion))
    print("  Completeopt: " .. vim.inspect(vim.opt.completeopt:get()))

    -- Test completion trigger
    local clients = vim.lsp.get_active_clients()
    print("  LSP Clients: " .. #clients)
    for _, client in pairs(clients) do
        print("    - " ..
            client.name ..
            " (supports completion: " .. tostring(client.server_capabilities.completionProvider ~= nil) .. ")")
    end
end, {})

-- ADDED: Force completion trigger command
vim.api.nvim_create_user_command("CmpTrigger", function()
    local has_cmp, cmp = pcall(require, "cmp")
    if has_cmp then
        cmp.complete()
        print("Completion triggered manually")
    else
        print("CMP not available")
    end
end, {})
