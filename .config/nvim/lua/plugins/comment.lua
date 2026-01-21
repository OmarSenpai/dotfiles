-- plugins/comment.lua
return {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
        require('Comment').setup({
            -- Add a space between comment and line
            padding = true,
            -- Ignore empty lines
            ignore = '^$',
        })
    end,
}
