return {
    "akinsho/bufferline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    version = "4.9.1",

    config = function()
        require('bufferline').setup({
            options = {
                mode = 'buffers',
                numbers = 'ordinal',

                show_buffer_close_icons = true,
                show_close_icons = true,
                show_tab_indicators = true,

                separator_style = 'slant',
                indicator_icon = '▎',
                modified_icon = '●',
                diagnostics = 'nvim_lsp',

                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and " "
                            or (e == "warning" and " " or " ")
                        s = s .. n .. sym
                    end
                    return s
                end,

                offsets = {
                    {
                        filetype = 'NvimTree',
                        text = 'File Explorer',
                        text_align = 'left',
                        separator = true,
                    },
                },
            },

            highlights = {
                buffer_selected = {
                    bold = true,
                    underline = false,
                },

                indicator_selected = {
                    fg = '#98C379', -- Example: A pleasant green color (Monokai-like)
                    bold = true,
                },
            }
        })
    end
}
