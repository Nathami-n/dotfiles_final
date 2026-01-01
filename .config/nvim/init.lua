if vim.g.vscode then
  vim.g.lazyvim_vscode = true
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
