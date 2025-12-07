require("config.lazy")

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd.colorscheme("Midnight")
    end,
})

vim.opt.number = true
vim.opt.scrolloff = 12
