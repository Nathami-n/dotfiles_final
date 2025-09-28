-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_augroup("AutoSave", { clear = true })

-- vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
--   group = "AutoSave",
--   pattern = "*",
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()
--     if vim.bo[bufnr].modifiable and not vim.bo[bufnr].readonly then
--       vim.cmd("silent! write")
--     end
--   end,
-- })
