local M = {}

M.setup = function()
    local colors = require("themes.Midnight.palette")
    c = colors

    return {
        -- Editor UI
        Normal = { fg = colors.fg0, bg = colors.bg0 },
        NormalFloat = { fg = colors.fg0, bg = colors.bg2 },
        FloatBorder = { fg = colors.border, bg = colors.black },
        CursorLine = { bg = colors.bg4 },
        CursorLineNr = { fg = colors.cursor_line_nr },
        LineNr = { fg = colors.line_nr, bg = colors.gutter_bg },
        SignColumn = { bg = colors.gutter_bg },
        StatusLine = { fg = colors.fg0, bg = colors.bg1 },
        StatusLineNC = { fg = colors.fg3, bg = colors.bg1 },
        VertSplit = { fg = c.black },
        WinSeparator = { fg = c.black },
        Visual = { bg = colors.visual },
        Search = { bg = colors.search },
        IncSearch = { bg = colors.inc_search },
        Pmenu = { fg = colors.fg1, bg = colors.pmenu },
        PmenuSel = { fg = colors.fg1, bg = colors.pmenu_sel },
        PmenuSbar = { bg = colors.bg2 },
        PmenuThumb = { bg = colors.fg3 },
        TabLine = { fg = colors.fg1, bg = colors.bg1 },
        TabLineFill = { bg = colors.bg1 },
        TabLineSel = { fg = colors.fg0, bg = colors.bg0 },

        -- Syntax highlighting
        Comment = { fg = colors.gray, italic = true },
        Constant = { fg = colors.beige },
        String = { fg = colors.orange },
        Character = { fg = colors.orange },
        Number = { fg = colors.beige },
        Boolean = { fg = colors.blue },
        Float = { fg = colors.gold },
        Identifier = { fg = colors.lightblue },
        Function = { fg = colors.yellow },
        Statement = { fg = colors.noct },
        Conditional = { fg = colors.lightblue },
        Repeat = { fg = colors.Havelock_blue },
        Label = { fg = colors.noct },
        Operator = { fg = colors.fg0 },
        Keyword = { fg = colors.Amethyst },
        Exception = { fg = colors.arch },
        PreProc = { fg = colors.seagull },
        Include = { fg = colors.lightblue },
        Define = { fg = colors.lightblue },
        Macro = { fg = colors.sky },
        PreCondit = { fg = colors.Amethyst },
        Type = { fg = colors.Turqoise },
        StorageClass = { fg = colors.light_purple },
        Structure = { fg = colors.Havelock_blue },
        Typedef = { fg = colors.beige },
        Special = { fg = colors.lightblue },
        SpecialChar = { fg = colors.gold },
        Tag = { fg = colors.Havelock_blue },
        Delimiter = { fg = colors.fg0 },
        SpecialComment = { fg = colors.green },
        Debug = { fg = colors.red },
        Underlined = { underline = true },
        Error = { fg = colors.red },
        Todo = { fg = colors.gold, bold = true },

        -- LSP
        DiagnosticError = { fg = colors.red },
        DiagnosticWarn = { fg = colors.gold },
        DiagnosticInfo = { fg = colors.blue },
        DiagnosticHint = { fg = colors.green },
        ReferenceText = { bg = colors.bg3 },
        LspReferenceRead = { bg = colors.bg3 },
        LspReferenceWrite = { bg = colors.bg3 },

        -- Treesitter
        ["@keyword.define"] = { fg = colors.arch },
        ["@variable"] = { fg = colors.fg1 },
        ["@variable.builtin"] = { fg = colors.lightblue },
        ["@function"] = { fg = colors.light_mint },
        ["@function.builtin"] = { fg = colors.yellow },
        ["@function.call"] = { fg = colors.beige },
        ["@method"] = { fg = colors.yellow },
        ["@method.call"] = { fg = colors.yellow },
        ["@keyword"] = { fg = colors.lightblue },
        ["@keyword.function"] = { fg = colors.arch },
        ["@keyword.operator"] = { fg = colors.seagull },
        ["@keyword.return"] = { fg = colors.Turqoise },
        ["@keyword.import"] = { fg = colors.lightblue },
        ["@keyword.conditional"] = { fg = c.Turqoise },
        ["@keyword.repeat"] = { fg = c.Turqoise },
        ["@type"] = { fg = colors.fg0 },
        ["@type.builtin"] = { fg = colors.lightblue },
        ["@namespace"] = { fg = colors.seagull },
        ["@parameter"] = { fg = colors.Havelock_blue },
        ["@property"] = { fg = colors.lightblue },
        ["@constant"] = { fg = colors.beige },
        ["@constant.builtin"] = { fg = colors.pink },
        ["@number"] = { fg = colors.beige },
        ["@float"] = { fg = colors.beige },
        ["@boolean"] = { fg = colors.Turqoise },
        ["@string"] = { fg = colors.orange },
        ["@comment"] = { fg = colors.gray, italic = true },
        ["@operator"] = { fg = colors.fg0 },
        ["@punctuation.bracket"] = { fg = colors.fg0 },
        ["@punctuation.delimiter"] = { fg = colors.fg0 },
        ["@constructor"] = { fg = colors.blue },
        ["@tag"] = { fg = colors.blue },
        ["@attribute"] = { fg = colors.lightblue },
        ["@type.qualifier"] = { fg = colors.light_purple }, -- auto, const
        ["@storageclass"] = { fg = colors.arch },           -- int, float, etc.

        -- Git signs
        GitSignsAdd = { fg = colors.git_add },
        GitSignsChange = { fg = colors.git_change },
        GitSignsDelete = { fg = colors.git_delete },

        -- Diff
        DiffAdd = { bg = colors.diff_add },
        DiffDelete = { bg = colors.diff_delete },
        DiffChange = { bg = colors.diff_change },
        DiffText = { bg = colors.diff_change },

        -- Telescope
        TelescopeBorder = { fg = colors.light_gray },
        TelescopeSelection = { bg = colors.pmenu_sel },
        TelescopeMatching = { fg = colors.yellow, bold = true },

        -- NeoTree
        NeoTreeNormal = { fg = c.fg1, bg = c.bg0 },
        NeoTreeNormalNC = { fg = c.fg1, bg = c.bg0 },
        NeoTreeDirectoryName = { fg = c.fg1 },
        NeoTreeDirectoryIcon = { fg = c.Havelock_blue },
        NeoTreeFileName = { fg1 = c.fg },
        NeoTreeFileIcon = { fg = c.fg_muted },
        NeoTreeRootName = { fg = c.fg0, bold = true },
        NeoTreeGitAdded = { fg = c.git_add },
        NeoTreeGitModified = { fg = c.git_change },
        NeoTreeGitDeleted = { fg = c.git_delete },
        NeoTreeGitUntracked = { fg = c.git_add },
        NeoTreeIndentMarker = { fg = c.bg3 },
        NeoTreeSymbolicLinkTarget = { fg = c.cyan },

        -- Dashboard
        DashboardHeader = { fg = c.arch },
        DashboardCenter = { fg = c.noct },
        DashboardFooter = { fg = c.fg_muted, italic = true },
        DashboardShortCut = { fg = c.Aquaforest },

        -- CMP (Autocompletion) - Main completion menu
        CmpNormal = { fg = c.fg0, bg = c.gutter_bg },      -- Menu background (lighter than bg0)
        CmpBorder = { fg = c.fg0, bg = c.bgfloat },        -- Border with matching bg
        CmpCursorLine = { bg = c.pmenu_sel },              -- Selected item background
        CmpItemAbbrMatch = { fg = c.yellow, bold = true }, -- Matching text highlight
        CmpItemAbbrMatchFuzzy = { fg = c.yellow },         -- Fuzzy match
        CmpItemKind = { fg = c.lightblue },                -- Icons/kind indicators
        CmpItemMenu = { fg = c.fg3 },                      -- Source name [LSP], [Buffer], etc.

        -- CMP Documentation window (darker than main menu for contrast)
        CmpDocNormal = { fg = c.fg0, bg = c.bg1 },     -- Documentation text (darker bg)
        CmpDocBorder = { fg = c.fg1, bg = c.bgfloat }, -- Documentation border (darker)

        -- LSP Signature help (function signatures)
        LspSignatureActiveParameter = { fg = c.yellow, bold = true },

        -- LSP Hover documentation
        -- These use NormalFloat and FloatBorder by default, but you can override:
        LspInfoBorder = { fg = c.fg0, bg = c.bgfloat }, -- LSP info window border
    }
end

return M
