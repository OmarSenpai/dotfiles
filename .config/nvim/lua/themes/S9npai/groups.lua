-- lua/S9npai/groups.lua
local M = {}

M.setup = function()
    local c = require("themes.S9npai.palette")

    return {
        -- === EDITOR ===
        Normal = { fg = c.fg, bg = c.bg },
        NormalFloat = { fg = c.fg, bg = c.bg_float },
        FloatBorder = { fg = c.fg, bg = c.bg_float },
        FloatTitle = { fg = c.fg_bright, bg = c.bg_float, bold = true },

        -- Cursor & Lines
        Cursor = { fg = c.bg, bg = c.blue_dark },
        CursorLine = { bg = c.cursorline },
        CursorLineNr = { fg = c.fg_bright, bold = true },
        LineNr = { fg = c.fg_muted },
        SignColumn = { fg = c.fg_muted, bg = c.bg },

        -- Selection & Visual
        Visual = { bg = c.dark_gray },
        VisualNOS = { bg = c.selection_alt },

        -- Search
        Search = { bg = c.selection_alt, fg = c.fg_bright },
        IncSearch = { bg = c.blue_dark, fg = c.white },
        CurSearch = { bg = c.blue_dark, fg = c.white, bold = true },

        -- Splits & Windows
        VertSplit = { fg = c.border },
        WinSeparator = { fg = c.border },

        -- Statusline & Tabline
        StatusLine = { fg = c.fg, bg = c.bg_dark },
        StatusLineNC = { fg = c.fg_muted, bg = c.bg_darker },
        TabLine = { fg = c.fg_muted, bg = c.bg_sidebar },
        TabLineFill = { bg = c.bg_darker },
        TabLineSel = { fg = c.fg_bright, bg = c.bg_float, bold = true },

        -- Popup Menu
        Pmenu = { fg = c.fg, bg = c.bg_float },
        PmenuSel = { fg = c.fg_bright, bg = c.selection },
        PmenuSbar = { bg = c.surface },
        PmenuThumb = { bg = c.border_variant },

        -- Folding
        Folded = { fg = c.fg_muted, bg = c.surface },
        FoldColumn = { fg = c.fg_muted, bg = c.bg },

        -- Diff
        DiffAdd = { fg = c.git_add, bg = c.bg },
        DiffChange = { fg = c.git_change, bg = c.bg },
        DiffDelete = { fg = c.git_delete, bg = c.bg },
        DiffText = { fg = c.git_change, bg = c.selection_alt },

        -- Spelling
        SpellBad = { sp = c.error, undercurl = true },
        SpellCap = { sp = c.warning, undercurl = true },
        SpellLocal = { sp = c.info, undercurl = true },
        SpellRare = { sp = c.hint, undercurl = true },

        -- === SYNTAX (Standard Vim) ===
        Comment = { fg = c.fg_gray, italic = true },

        Constant = { fg = c.purple },
        String = { fg = c.orange },
        Character = { fg = c.orange },
        Number = { fg = c.cyan_bright },
        Boolean = { fg = c.blue },
        Float = { fg = c.cyan_bright },

        Identifier = { fg = c.fg },
        Function = { fg = c.cyan_green },

        Statement = { fg = c.blue },
        Conditional = { fg = c.blue },
        Repeat = { fg = c.blue },
        Label = { fg = c.blue },
        Operator = { fg = c.fg },
        Keyword = { fg = c.blue },
        Exception = { fg = c.blue },

        PreProc = { fg = c.blue },
        Include = { fg = c.blue },
        Define = { fg = c.blue },
        Macro = { fg = c.blue },
        PreCondit = { fg = c.blue },

        Type = { fg = c.purple },
        StorageClass = { fg = c.blue },
        Structure = { fg = c.purple },
        Typedef = { fg = c.purple },

        Special = { fg = c.cyan },
        SpecialChar = { fg = c.cyan },
        Tag = { fg = c.purple },
        Delimiter = { fg = c.fg },
        SpecialComment = { fg = c.fg_muted, italic = true },
        Debug = { fg = c.error },

        Underlined = { underline = true },
        Bold = { bold = true },
        Italic = { italic = true },

        Error = { fg = c.error },
        Todo = { fg = c.warning, bold = true },

        -- === TREESITTER ===
        -- Identifiers
        ["@variable"] = { fg = c.fg },
        ["@variable.builtin"] = { fg = c.blue },
        ["@variable.parameter"] = { fg = c.fg },
        ["@variable.member"] = { fg = c.teal },

        ["@constant"] = { fg = c.purple },
        ["@constant.builtin"] = { fg = c.purple },
        ["@constant.macro"] = { fg = c.purple },

        ["@module"] = { fg = c.fg },
        ["@label"] = { fg = c.blue },

        -- Literals
        ["@string"] = { fg = c.orange },
        ["@string.escape"] = { fg = c.fg },
        ["@string.regexp"] = { fg = c.cyan },
        ["@character"] = { fg = c.orange },
        ["@number"] = { fg = c.cyan_bright },
        ["@boolean"] = { fg = c.blue },
        ["@float"] = { fg = c.cyan_bright },

        -- Functions
        ["@function"] = { fg = c.cyan_green, bold = true },
        ["@function.builtin"] = { fg = c.cyan_green },
        ["@function.call"] = { fg = c.cyan_green, bold = true },
        ["@function.macro"] = { fg = c.cyan_green },
        ["@function.method"] = { fg = c.cyan_green, bold = true },
        ["@function.method.call"] = { fg = c.cyan_green, bold = true },
        ["@constructor"] = { fg = c.purple },

        -- Keywords
        ["@keyword"] = { fg = c.blue, bold = true },
        ["@keyword.function"] = { fg = c.blue, bold = true },
        ["@keyword.operator"] = { fg = c.blue },
        ["@keyword.return"] = { fg = c.blue },
        ["@keyword.conditional"] = { fg = c.blue },
        ["@keyword.repeat"] = { fg = c.blue },
        ["@keyword.import"] = { fg = c.blue, bold = true },

        -- Operators
        ["@operator"] = { fg = c.fg },

        -- Punctuation
        ["@punctuation.delimiter"] = { fg = c.fg },
        ["@punctuation.bracket"] = { fg = c.fg },
        ["@punctuation.special"] = { fg = c.fg },

        -- Types
        ["@type"] = { fg = c.purple },
        ["@type.builtin"] = { fg = c.purple },
        ["@type.definition"] = { fg = c.purple },
        ["@type.qualifier"] = { fg = c.blue },

        ["@property"] = { fg = c.teal },
        ["@attribute"] = { fg = c.green },

        -- Comments
        ["@comment"] = { fg = c.fg_gray, italic = true },
        ["@comment.documentation"] = { fg = c.fg_muted, italic = true },

        -- Markup (Markdown, etc)
        ["@markup.strong"] = { bold = true },
        ["@markup.italic"] = { italic = true },
        ["@markup.underline"] = { underline = true },
        ["@markup.heading"] = { fg = c.purple, bold = true },
        ["@markup.link"] = { fg = c.blue_bright, underline = true },
        ["@markup.link.url"] = { fg = c.blue_bright, italic = true },
        ["@markup.list"] = { fg = c.fg },
        ["@markup.raw"] = { fg = c.orange },

        -- Tags (HTML/XML)
        ["@tag"] = { fg = c.purple },
        ["@tag.attribute"] = { fg = c.green },
        ["@tag.delimiter"] = { fg = c.fg },

        -- === DIAGNOSTICS ===
        DiagnosticError = { fg = c.error },
        DiagnosticWarn = { fg = c.warning },
        DiagnosticInfo = { fg = c.info },
        DiagnosticHint = { fg = c.hint },

        DiagnosticUnderlineError = { sp = c.error, undercurl = true },
        DiagnosticUnderlineWarn = { sp = c.warning, undercurl = true },
        DiagnosticUnderlineInfo = { sp = c.info, undercurl = true },
        DiagnosticUnderlineHint = { sp = c.hint, undercurl = true },

        -- === LSP ===
        LspReferenceText = { bg = c.selection_alt },
        LspReferenceRead = { bg = c.selection_alt },
        LspReferenceWrite = { bg = c.selection_alt },

        -- === GIT SIGNS ===
        GitSignsAdd = { fg = c.git_add },
        GitSignsChange = { fg = c.git_change },
        GitSignsDelete = { fg = c.git_delete },

        -- === NEO-TREE ===
        NeoTreeNormal = { fg = c.fg, bg = c.bg_sidebar },
        NeoTreeNormalNC = { fg = c.fg, bg = c.bg_sidebar },
        NeoTreeDirectoryName = { fg = c.fg },
        NeoTreeDirectoryIcon = { fg = c.light_cyan },
        NeoTreeFileName = { fg = c.fg },
        NeoTreeFileIcon = { fg = c.fg_muted },
        NeoTreeRootName = { fg = c.fg, bold = true },
        NeoTreeGitAdded = { fg = c.git_add },
        NeoTreeGitModified = { fg = c.git_change },
        NeoTreeGitDeleted = { fg = c.git_delete },
        NeoTreeGitUntracked = { fg = c.git_add },
        NeoTreeIndentMarker = { fg = c.border_variant },
        NeoTreeSymbolicLinkTarget = { fg = c.cyan },

        -- === TELESCOPE ===
        TelescopeNormal = { fg = c.fg, bg = c.bg_float },
        TelescopeBorder = { fg = c.fg, bg = c.bg_float },
        TelescopeTitle = { fg = c.fg_bright, bg = c.bg_float, bold = true },
        TelescopeSelection = { fg = c.fg_bright, bg = c.dark_gray },
        TelescopeSelectionCaret = { fg = c.fg_bright, bg = c.bg },
        TelescopeMultiSelection = { fg = c.fg_bright, bg = c.selection_alt },
        TelescopeMatching = { fg = c.fg, bold = true },
        TelescopePromptPrefix = { fg = c.blue_dark },

        -- === LUALINE ===

        -- === WHICH-KEY ===
        WhichKey = { fg = c.blue_bright },
        WhichKeyGroup = { fg = c.purple },
        WhichKeySeparator = { fg = c.fg_muted },
        WhichKeyDesc = { fg = c.fg },
        WhichKeyFloat = { bg = c.bg_float },
        WhichKeyBorder = { fg = c.border_focused, bg = c.bg_float },

        -- === CMP (Autocompletion) ===
        CmpItemAbbrDeprecated = { fg = c.fg_muted, strikethrough = true },
        CmpItemAbbrMatch = { fg = c.blue_bright, bold = true },
        CmpItemAbbrMatchFuzzy = { fg = c.blue_bright },
        CmpItemKindVariable = { fg = c.fg },
        CmpItemKindInterface = { fg = c.purple },
        CmpItemKindText = { fg = c.fg },
        CmpItemKindFunction = { fg = c.cyan_green },
        CmpItemKindMethod = { fg = c.cyan_green },
        CmpItemKindKeyword = { fg = c.blue },
        CmpItemKindProperty = { fg = c.teal },
        CmpItemKindUnit = { fg = c.purple },

        -- === INDENT BLANKLINE ===
        IblIndent = { fg = c.border_variant },
        IblScope = { fg = c.border_focused },

        -- === DASHBOARD ===
        DashboardHeader = { fg = c.purple_blue },
        DashboardCenter = { fg = c.purple },
        DashboardFooter = { fg = c.fg_muted, italic = true },
        DashboardShortCut = { fg = c.cyan_green },
    }
end

return M
