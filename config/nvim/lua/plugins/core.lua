return {
    -----------------------------------------------------------------------------
    --  Treesitter
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
}
