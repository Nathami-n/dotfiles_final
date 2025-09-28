-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = false })
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = false })

vim.keymap.set("n", "<leader>fo", function()
  require("neo-tree.command").execute({ action = "focus" })
end, { desc = "Focus Neo-tree" })

vim.keymap.set("n", "<leader>bf", function()
  require("neo-tree.command").execute({ source = "buffers", action = "focus" })
end, { desc = "Neo tree Buffers" })
