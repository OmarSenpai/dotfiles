-- This is the file Neovim's `:colorscheme S9npai` will call
-- Reset highlights

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

-- vim.g.colors_name = "S9npai

require("themes.S9npai").setup()
