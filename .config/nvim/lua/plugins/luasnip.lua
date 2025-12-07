-- lua/plugins/luasnip.lua

return {
    "L3MON4D3/LuaSnip",
    -- Keybindings for expanding and jumping through snippets
    keys = {
        -- Keymap for expanding a snippet (if there is one)
        {
            "<C-j>",
            function()
                require("luasnip").jump(1)
            end,
            mode = "i",
            desc = "Snippet Jump Forward",
        },
        -- Keymap for jumping backward
        {
            "<C-k>",
            function()
                require("luasnip").jump(-1)
            end,
            mode = { "i", "s" },
            desc = "Snippet Jump Backward",
        },
        -- Select the next possible choice in a snippet
        {
            "<C-l>",
            function()
                if require("luasnip").choice_active() then
                    require("luasnip").change_choice(1)
                end
            end,
            mode = { "i", "s" },
            desc = "Snippet Next Choice",
        },
    },
    config = function()
        local ls = require("luasnip")

        -- Set the trigger to expand a snippet (e.g., 'for' <Tab> -> 'for loop')
        -- We will rely on nvim-cmp to handle the <Tab> key and only call expand when appropriate.
        ls.config.set_config({
            -- Enable auto-jumping to the next field upon expansion
            history = true,
            -- Update existing snippets/placeholders when a jump occurs
            update_events = "textchanged",
            -- Show the choice list when possible (for choosing between snippet variants)
            ext_opts = {
                [1] = {
                    active = {
                        virt_text = { { "<- choice", "Comment" } },
                    },
                },
            },
        })
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
