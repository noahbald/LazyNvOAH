-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.keymap.set("n", "<leader><cr>", "<leader>fE", { remap = true, desc = "Explorer NeoTree" })
vim.keymap.set("n", "<C-x>", "<leader>bd", { remap = true, desc = "Delete buffer" })

vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>L")
