-- lua/plugins/cmp.lua

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- Configure the sources for completion
            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip",  priority = 750 },
                { name = "buffer",   priority = 500 },
                { name = "path",     priority = 250 },
            }),

            -- Configure the appearance
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            -- Use lspkind to show icons
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text',
                    maxwidth = 50,
                    ellipsis_char = '...',
                    menu = {
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snippet]",
                        path = "[Path]",
                    },
                }),
            },

            -- Set keybindings
            mapping = cmp.mapping.preset.insert({
                -- Select next item
                ["<C-n>"] = cmp.mapping.select_next_item(),
                -- Select previous item
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                -- Scroll documentation down
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                -- Scroll documentation up
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                -- Manually trigger completion
                ["<C-Space>"] = cmp.mapping.complete(),
                -- Close completion menu
                ["<C-e>"] = cmp.mapping.abort(),
                -- Accept currently selected item
                ["<CR>"] = cmp.mapping.confirm({ select = true }),

                -- Tab: completion selection AND snippet expansion
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                -- Shift-Tab: backward jump
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            -- CRITICAL: Enable completion as you type
            completion = {
                completeopt = "menu,menuone,noinsert",
            },

            -- Enable experimental features
            experimental = {
                ghost_text = false, -- or true if you want inline suggestions
            },
        })
    end,
}
