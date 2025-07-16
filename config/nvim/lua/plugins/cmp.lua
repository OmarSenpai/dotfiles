-- ~/.config/nvim/lua/plugins/cmp.lua

return {
    -----------------------------------------------------------------------------
    -- Autocompletion Engine (nvim-cmp)
    -----------------------------------------------------------------------------
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter", -- Load cmp when entering Insert mode
        dependencies = {
            -- Core sources for nvim-cmp
            "hrsh7th/cmp-nvim-lsp",     -- LSP source (for completions from language servers)
            "hrsh7th/cmp-buffer",       -- Buffer source (for completions from current/other open buffers)
            "hrsh7th/cmp-path",         -- Path source (for file system path completions)
            "saadparwaiz1/cmp_luasnip", -- LuaSnip integration (for snippet completions)

            -- Snippet engine and collection
            "L3MON4D3/LuaSnip",             -- The snippet engine
            "rafamadriz/friendly-snippets", -- A collection of common snippets

            -- Optional: For icons in the completion menu
            "nvim-tree/nvim-web-devicons", -- Provides file-type icons
            "onsails/lspkind.nvim",        -- Adds LSP kind icons to cmp menu
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Load snippets from friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    -- REQUIRED - This tells nvim-cmp how to expand snippets using LuaSnip
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                -- FIXED: Enable completion in insert mode
                completion = {
                    autocomplete = { "TextChanged" },      -- Trigger completion on text changes
                    completeopt = "menu,menuone,noselect", -- Better completion options
                },

                window = {
                    -- Custom borders for completion and documentation windows
                    completion = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
                    }),
                    documentation = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
                    }),
                },

                mapping = cmp.mapping.preset.insert({
                    -- Navigation
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),           -- Scroll documentation up
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),            -- Scroll documentation down
                    ["<C-Space>"] = cmp.mapping.complete(),            -- Manually trigger completion
                    ["<C-e>"] = cmp.mapping.abort(),                   -- Abort completion
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection

                    -- FIXED: Better Tab/Shift-Tab for navigation and snippet expansion
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()   -- Select next item in completion menu
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump() -- Expand or jump to next placeholder in snippet
                        else
                            fallback()               -- Fallback to default tab behavior
                        end
                    end, { "i", "s" }),              -- Apply in Insert and Snippet modes

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item() -- Select previous item in completion menu
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)       -- Jump to previous placeholder in snippet
                        else
                            fallback()             -- Fallback to default shift-tab behavior
                        end
                    end, { "i", "s" }),

                }),

                -- FIXED: Better source configuration with priorities
                sources = cmp.config.sources({
                    {
                        name = "nvim_lsp",
                        priority = 1000,
                        max_item_count = 20,
                    },
                    {
                        name = "luasnip",
                        priority = 750,
                        max_item_count = 5,
                    },
                }, {
                    {
                        name = "buffer",
                        priority = 500,
                        max_item_count = 10,
                        keyword_length = 3,
                    },
                    {
                        name = "path",
                        priority = 250,
                        max_item_count = 10,
                    },
                }),

                -- FIXED: Better formatting with more details
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",     -- Show both symbol and text
                        maxwidth = 50,            -- Max width of the label
                        ellipsis_char = "...",    -- Character to use when label is truncated
                        show_labelDetails = true, -- Show function signatures and more
                        before = function(entry, vim_item)
                            -- Show source in menu
                            vim_item.menu = ({
                                nvim_lsp = "[LSP]",
                                luasnip = "[Snippet]",
                                buffer = "[Buffer]",
                                path = "[Path]",
                            })[entry.source.name]
                            return vim_item
                        end,
                    }),
                },

                -- FIXED: Enable experimental features for better completion
                experimental = {
                    ghost_text = true, -- Show ghost text for completion
                },
            })

            -- ADDED: Better completion for specific file types
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'buffer' },
                })
            })

            -- ADDED: Better completion for command line
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
    },

    -----------------------------------------------------------------------------
    -- Snippet Engine (LuaSnip) and Snippet Collection
    -----------------------------------------------------------------------------
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp", -- Important for some advanced regex snippets
        dependencies = { "rafamadriz/friendly-snippets" },
        event = "InsertEnter",           -- Load LuaSnip when entering Insert mode
        config = function()
            require("luasnip").setup({
                history = true,                            -- Remember last snippet
                delete_check_events = "TextChanged",       -- Delete snippets when text changes
                updateevents = "TextChanged,TextChangedI", -- Update snippets on text changes
            })
        end,
    },

    {
        "rafamadriz/friendly-snippets",
        dependencies = { "L3MON4D3/LuaSnip" },
    },

    -----------------------------------------------------------------------------
    -- Optional: LSP Kind Icons for Completion Menu
    -----------------------------------------------------------------------------
    {
        "onsails/lspkind.nvim",
        event = "InsertEnter",
        config = function()
            require("lspkind").init({
                -- Enable text annotations
                mode = 'symbol_text',
                -- Default symbol map
                preset = 'codicons',
                -- Override specific symbols
                symbol_map = {
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰊕",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈙",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                },
            })
        end,
    },

    -- ADDED: Command line completion
    {
        "hrsh7th/cmp-cmdline",
        event = "CmdlineEnter",
    },
}
