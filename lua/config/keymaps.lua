-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Use `;` to open command palette
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
-- Add quick shortcut NeoTree
vim.keymap.set("n", "<leader><cr>", "<leader>fE", { remap = true, desc = "Explorer NeoTree" })
-- Add quick shortcut to delete bugger
vim.keymap.set("n", "<C-x>", "<leader>bd", { remap = true, desc = "Delete buffer" })
-- Remove lazyvim from top-level of which-key
vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>L")
-- Remove remaps from flash
vim.keymap.del("n", "f")
vim.keymap.del("n", "F")
