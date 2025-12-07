return {
    -- Syntax highlightings
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- CORRECTED: Use the official 'FileType' event for the list of languages.
        -- This ensures the plugin loads when you open a recognized file,
        -- which is the safest way to lazy-load Treesitter.
        event = "FileType",
        ft = {
            "astro", "bash", "c", "cpp", "cmake", "c_sharp", "css", "diff",
            "dockerfile", "html", "java", "javascript", "json", "jsonc",
            "lua", "markdown", "markdown_inline", "python", "rust", "toml",
            "tsx", "typescript", "terraform", "vim", "zig", "xml", "yaml",
            "php", "perl", "scala", "nix", "nginx", "go", "gomod", "latex"
        },
        opts = {
            highlight = { enable = true },
            indent = {
                enable = true,
                -- disable = { "python" },
            },
            ensure_installed = {
                "astro",
                "bash",
                "c",
                "cpp",
                "cmake",
                "c_sharp",
                "cuda",
                "csv",
                "css",
                "diff",
                "dockerfile",
                "glsl",
                "html",
                "java",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "julia",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "printf",
                "python",
                "query",
                "regex",
                "rust",
                "toml",
                "tsx",
                "typescript",
                "terraform",
                "vim",
                "vimdoc",
                "zig",
                "xml",
                "yaml",
                "php",
                "perl",
                "python",
                "scala",
                "nix",
                "nginx",
                "meson",
                "latex",
                "hyprlang",
                "go",
                "gomod",
            },
            auto_install = true,
            ignore_install = { "dockerfile" },
        },
        config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        -- CORRECTED: Using 'FileType' as it depends on core Treesitter being loaded for a file.
        event = "BufReadPre",
        opts = function()
            local ret = {
                enable = false,           -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20,     -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }
            vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
            local tsc = require("treesitter-context")

            return ret
        end,
    },
}
