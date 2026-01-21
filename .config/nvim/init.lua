require("config.lazy")
require('config.envselector')

-- ايوه خلي الvim يستعمل دي مش أي clipboard ثانية
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd.colorscheme("Midnight")
    end,
})

vim.opt.number = true
vim.opt.scrolloff = 12
