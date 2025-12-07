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

                -- Split the content by newline to get a table of lines for the header
                -- 'trimempty = true' removes any leading/trailing empty lines if the file has them.
                return vim.split(content, "\n", { plain = true, trimempty = true })
            else
                print("Error: Could not read logo file at: " .. filepath)
                return { "Nvim", "Dashboard" }
            end
        end

        -- Get the header lines from the file
        local custom_header = read_logo(logo_file_path)


        require('dashboard').setup({
            config = {

                header = custom_header,

                center = {
                    { icon = "󰈞 ", desc = "Find File", action = "Telescope find_files", key = "f" },
                    { icon = " ", desc = "New File", action = "ene | startinsert", key = "n" },
                    { icon = " ", desc = "Recent Files", action = "Telescope oldfiles", key = "r" },
                    { icon = " ", desc = "Config", action = "lua LazyVim.pick.config_files()()", key = "c" }, -- Example path from original file
                    { icon = "󰒲 ", desc = "Lazy", action = "Lazy", key = "p" },
                    { icon = "󰐥 ", desc = "Quit", action = "qa", key = "q" },
                },
            },
        })
    end
}
