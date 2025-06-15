return {

    -----------------------------------------------------------------------------
    --  1. Nvimtree File Explorer & icons
    -----------------------------------------------------------------------------

    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
        opts = {},
    },


    {
        "nvim-tree/nvim-tree.lua",
        cmd = "NvimTreeToggle",

        dependencies = { "nvim-tree/nvim-web-devicons" },

        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 30,            --tree width
                    relativenumber = true, -- =relative line numbers
                    disable_netrw = true
                },

                renderer = {
                    group_empty = true,
                    highlight_git = true,
                    icons = {
                        git_placement = "before", --git icons before filename
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true
                        },
                    },
                },

                filters = {
                    dotfiles = true, --show dotfiles
                },

                git = {
                    ignore = false,
                    custom = {},
                },

                actions = {
                    open_file = {
                        quit_on_open = false,
                        no_window_picker = false
                    },
                },

                -- Set Nvimtree keymaps
                on_attach = function(bufnr)
                    local api = require("nvim-tree.api")

                    local function opts(desc)
                        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                    end

                    -- The line for defining default mappings (api.nvim_tree_keys.define_mappings) is no longer valid
                    -- and has been removed/deprecated in newer nvim-tree versions.
                    -- If you need specific default mappings, you'd typically define them
                    -- in the `actions` table within the nvim-tree.setup() itself,
                    -- or explicitly map them here like your custom ones below.

                    -- Custom mappings using the current nvim-tree.api
                    -- These are generally more stable across updates.
                    -- Always refer to `:h nvim-tree.api` for the very latest API if these ever break again.

                    -- NvimTree Toggle (this is defined in keymaps.lua, but showing here for completeness if you wanted it here)
                    -- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

                    -- 'h': Go to parent directory
                    vim.keymap.set("n", "h", function()
                        api.tree.change_root("..")
                    end, opts("Go to parent directory"))

                    -- '<CR>': Change root to the selected node (enter folder subtree)
                    vim.keymap.set("n", "<CR>", api.tree.change_root_to_node, opts("Change root to node"))

                    -- 'l': Open file / expand directory
                    vim.keymap.set("n", "l", api.node.open.edit, opts("Open file"))

                    -- 'K': Previous sibling
                    vim.keymap.set("n", "K", api.node.navigate.sibling.prev, opts("Previous Sibling"))

                    -- 'J': Next sibling
                    vim.keymap.set("n", "J", api.node.navigate.sibling.next, opts("Next Sibling"))
                end,
            })
        end,
    },

    -----------------------------------------------------------------------------
    --  2. Treesitter
    -----------------------------------------------------------------------------

    -- Nvim Treesitter - For advanced syntax highlighting and parsing
    {
        "nvim-treesitter/nvim-treesitter", -- The Treesitter plugin
        lazy = false,                      -- Load immediately as it's fundamental for syntax highlighting
        build = ":TSUpdate",               -- This command will be run *after* the plugin is installed/updated.
        -- It's used to download and compile the Treesitter parsers for languages.
        config = function()
            require("nvim-treesitter.configs").setup({ -- Setup Treesitter configurations
                -- List of languages for which Treesitter parsers should be installed
                ensure_installed = {
                    "astro",
                    "asm",
                    "bash",
                    "c",
                    "cpp",
                    "c_sharp",
                    "cmake",
                    "css",
                    "csv",
                    "cuda",
                    "dart",
                    "desktop",
                    "dockerfile",
                    "git_config",
                    "gitignore",
                    "git_rebase",
                    "gitcommit",
                    "gitattributes",
                    "go",
                    "graphql",
                    "groovy",
                    "java",
                    "javascript",
                    "typescript",
                    "tsx",
                    "prisma",
                    "toml",
                    "python",
                    "php",
                    "perl",
                    "ocaml",
                    "rust",
                    "sql",
                    "swift",
                    "scala",
                    "lua",
                    "vim",
                    "zig",
                    "xml",
                    "yaml",
                    "ninja",
                    "nix",
                    "nginx",
                    "meson",
                    "json",
                    "jsonc",
                    "terraform",
                    "latex",
                    "llvm",
                    "julia",
                    "jinja",
                },
                sync_install = false,                          -- Do not install parsers synchronously (prevents blocking Neovim startup)
                auto_install = true,                           -- Automatically install missing parsers when you open a file of that type
                highlight = {                                  -- Configuration for Treesitter's highlighting feature
                    enable = true,                             -- Enable Treesitter highlighting
                    additional_vim_regex_highlighting = false, -- Disable Vim's regex highlighting where Treesitter can take over
                },
                indent = { enable = true },                    -- Enable Treesitter-based indentation (more accurate than default Vim indent)
            })
        end,
    },

    -----------------------------------------------------------------------------
    --  3. Lua line
    -----------------------------------------------------------------------------

    {
        "nvim-lualine/lualine.nvim",
        lazy = false, -- Status line should be available immediately
        -- Ensure devicons are loaded if you want icons in your status line
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { -- Use the 'opts' table to pass configuration directly to lualine's setup()
            options = {
                icons_enabled = true, -- Enable showing file/folder icons
                theme = "auto", -- Use an auto-detected theme, or specify 'tokyonight' for consistency
                -- Component and section separators define the visual style of your status line
                component_separators = { left = "", right = "" }, -- UTF-8 triangles for separation
                section_separators = { left = "", right = "" }, -- UTF-8 triangles for sections
                disabled_filetypes = { -- Filetypes where Lualine should be disabled
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},                                    -- Filetypes where Lualine ignores window focus
                always_last_status = true,                            -- Always show statusline in the last window
                padding = 1,                                          -- Padding around components
            },
            sections = {                                              -- Define what content goes into each section of the active status line
                lualine_a = { "mode" },                               -- Mode (NORMAL, INSERT, VISUAL, etc.)
                lualine_b = { "branch", "diff", "diagnostics" },      -- Git branch, Git diff changes, LSP diagnostics (errors, warnings)
                lualine_c = { { "filename", path = 1 } },             -- Current filename, with path=1 to show relative path
                lualine_x = { "encoding", "fileformat", "filetype" }, -- File encoding, format (unix/dos), and type
                lualine_y = { "progress" },                           -- Percentage of file scrolled
                lualine_z = { "location" },                           -- Current line and column number
            },
            inactive_sections = {                                     -- Define what content goes into each section of inactive status lines
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "filename", path = 1 } }, -- Only filename for inactive windows
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},    -- Set to {} to disable, or configure a tabline for buffers
            extensions = {}, -- Add Lualine extensions here if needed (e.g., 'nvim-tree', 'lazy')
        },
    },

    -----------------------------------------------------------------------------
    --  4. Theme
    -----------------------------------------------------------------------------

    -- Colorscheme for syntax highlighting and overall look
    {
        "catppuccin/nvim",
        name = "catppuccin", -- Important for lazy.nvim to find it by name
        lazy = false,        -- Must be loaded immediately
        priority = 1000,     -- High priority to ensure it loads first
        config = function()
            require("catppuccin").setup({
                -- You can choose one of the 'flavour' options: 'mocha', 'macchiato', 'frappe', 'latte'
                flavour = "macchiato",         -- This is the darkest one, similar to the image
                transparent_background = true, -- <--- Set this to true for transparency!
                term_colors = true,            -- Apply Catppuccin colors to your terminal
                dim_inactive = {               -- Dim inactive windows for better focus
                    enabled = false,
                    shade = 0.6,
                    percentage = 0.7,
                },
                styles = { -- Customize styles for various elements
                    comments = { "italic" },
                    functions = { "bold" },
                    keywords = { "bold" },
                    strings = {},
                    variables = {},
                },
                integrations = { -- Integrations with other plugins
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    bufferline = true,
                    telescope = {
                        enabled = true,
                        native = false -- For Telescope's built-in themes
                    },
                    -- lualine = true, -- Lualine often picks up the colorscheme automatically,
                    -- but you can enable this for explicit integration
                    -- You can add more integrations as you add plugins
                },
                -- Customize specific highlight groups if needed
                -- custom_highlights = function(colors)
                --   return {
                --     LineNr = { fg = colors.surface0 }, -- Example: slightly lighter line numbers
                --   }
                -- end,
            })
            -- Set the colorscheme
            vim.cmd.colorscheme "catppuccin"
        end,
    },


    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            options = {
                theme = "catppuccin",
                separator_style = "slant",
            }
        }
    }
}
