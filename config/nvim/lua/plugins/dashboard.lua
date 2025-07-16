return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        local function greeting()
            local hour = tonumber(vim.fn.strftime("%H"))
            -- [02:00, 10:00) - morning, [10:00, 18:00) - day, [18:00, 02:00) - evening
            local part_id = math.floor((hour + 6) / 8) + 1
            local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
            local username = os.getenv("USER") or os.getenv("USERNAME") or "user"
            return ("Good %s, %s"):format(day_part, username)
        end

        local header = {
            "                                                                       ",
            "                                                                       ",
            "                                                                       ",
            "      ████ ██████           █████      ██                      ",
            "     ███████████             █████                              ",
            "     █████████ ███████████████████ ███   ███████████    ",
            "    █████████  ███    █████████████ █████ ██████████████    ",
            "   █████████ ██████████ █████████ █████ █████ ████ █████    ",
            " ███████████ ███    ███ █████████ █████ █████ ████ █████   ",
            "██████  █████████████████████ ████ █████ █████ ████ ██████  ",
            "                                                                       ",
            "                                                                       ",
            "                                                                       ",
        }

        require('dashboard').setup {
            theme = 'doom',
            config = {
                header = header,
                center = {
                    {
                        icon = '󰈞  ',
                        desc = 'Find file',
                        key = 'f',
                        action = 'Telescope find_files'
                    },
                    {
                        icon = '󰈬  ',
                        desc = 'Find word',
                        key = 's',
                        action = 'Telescope live_grep'
                    },
                    {
                        icon = '󰊄  ',
                        desc = 'Recent files',
                        key = 'r',
                        action = 'Telescope oldfiles'
                    },
                    {
                        icon = '󰒲  ',
                        desc = 'Lazy',
                        key = 'l',
                        action = 'Lazy'
                    },
                    {
                        icon = '󰗼  ',
                        desc = 'Quit',
                        key = 'q',
                        action = 'qa'
                    },
                },

                footer = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return {
                        "",
                        greeting(),
                        "",
                        "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
                        "",
                        "Test your software, or your users will.",
                        "",
                        "Test ruthlessly. Don't make your users find bugs for you."
                    }
                end,
            }
        }
    end,
    dependencies = {
        { 'nvim-tree/nvim-web-devicons' }
    }
}
