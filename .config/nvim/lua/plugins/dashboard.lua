return {
    'nvimdev/dashboard-nvim',

    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },

    config = function()
        local logo_file_path = vim.fn.stdpath("config") .. "/logos/nn_logo.txt"

        -- Function to read the logo file
        local function read_logo(filepath)
            local f = io.open(filepath, "r")
            if f then
                -- Read the entire file content
                local content = f:read("*a")
                io.close(f)

                return vim.split(content, "\n", { plain = true, trimempty = true })
            else
                print("Error: Could not read logo file at: " .. filepath)
                return { "Nvim", "Dashboard" }
            end
        end

        -- Get the header lines from the file
        local custom_header = read_logo(logo_file_path)


        require('dashboard').setup({
            -- critical: make theme outside config {}
            theme = 'doom',
            config = {
                header = custom_header,

                hide = {
                    statusline = false,
                    tabline = false,
                    winbar = false,
                },

                center = {
                    { icon = "󰈞 ", desc = "Find File                    ", action = "Telescope find_files", key = "f" },
                    { icon = " ", desc = "New File                     ", action = "ene | startinsert", key = "n" },
                    { icon = " ", desc = "Recent Files                 ", action = "Telescope oldfiles", key = "r" },
                    --requires plugin: github.com/ahmedkhalf/project.nvim
                    --{ icon = "󰆦 ", desc = "Projects                     ", action = "Telescope projects", key = "s" },
                    { icon = "󰒲 ", desc = "Lazy                         ", action = "Lazy", key = "p" },
                    { icon = "󱎥 ", desc = "Mason                        ", action = "Mason", key = "m" },
                    { icon = "󰐥 ", desc = "Quit                         ", action = "qa", key = "q" },
                },

                footer = {}
            },
        })
    end
}
