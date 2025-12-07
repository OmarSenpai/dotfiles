-- lua/S9npai/palette.lua

return {
    -- Background colors
    bg = "#1f1f21",         -- editor.background / alt:#202020
    bg_dark = "#191919",    -- status_bar/title_bar
    bg_darker = "#202020",  -- tab_bar
    bg_float = "#222222",   -- panel/toolbar
    bg_sidebar = "#212121", -- tab inactive

    -- Surface colors
    surface = "#2B2D30",       -- elevated surface
    cursorline = "#2B2D30",    -- active line
    selection = "#0A3783",     -- visual selection
    selection_alt = "#2E436B", -- secondary selection

    -- Foreground colors
    fg = "#DFDFDF",        -- main text
    fg_bright = "#F1F1F1", -- active line number
    fg_muted = "#9FA1A5",  -- muted text
    fg_gray = "#878787",   -- comments

    -- Border colors
    border = "#101010",
    border_variant = "#393B41",
    border_focused = "#3474F0",

    -- Syntax colors (from Zed syntax section)
    blue = "#6C95EB",          -- keyword, boolean
    blue_bright = "#82ACFC",   -- accent/icon
    blue_dark = "#3474F0",     -- focused border
    cyan = "#65C3CC",          -- operator alt
    cyan_bright = "#56CC9E",   -- number
    cyan_green = "#3ACC9C",    -- function
    light_cyan = "#5bc7c7",
    green = "#85C46C",         -- attribute
    orange = "#C8A16D",        -- string
    purple = "#C191FF",        -- type, constant, tag
    purple_bright = "#E2BFFF", -- enum
    pink = "#EC94C0",          -- terminal red
    teal = "#5997C0",          -- property
    mint = "#4AC9AC",
    lemon = "#81cc56",
    dark_gray = "#35343a",
    purple_blue = "#22b396",

    -- Diagnostic colors
    error = "#d51515",
    warning = "#c7c41a",
    info = "#4e77de",
    hint = "#6fd181",

    -- Git colors
    git_add = "#6fd181",
    git_change = "#6d96d9",
    git_delete = "#cc1b1b",

    -- Special
    white = "#ffffff",
    black = "#000000",
}
