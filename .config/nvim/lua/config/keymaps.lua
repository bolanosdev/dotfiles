-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>++", "<plug>NERDCommenterToggle")
vim.keymap.set("v", "<leader>++", "<plug>NERDCommenterToggle")

vim.keymap.set("n", "<leader>x", "_x")
vim.keymap.set("n", "<leader>X", "_X")

vim.keymap.set("n", "<leader>p", "_p")
vim.keymap.set("n", "<leader>P", "_P")

vim.keymap.set("n", "<leader>y", "_y")
vim.keymap.set("n", "<leader>Y", "_Y")

-- ysiw" surround insert word
-- ysa}] sorround word around curly brackets with brackets
-- cs{[ change surrounding curly brackets with square brackets
