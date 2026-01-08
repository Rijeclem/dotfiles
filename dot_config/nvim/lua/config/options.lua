-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Safely disable LazyVim resize autocmd
pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_resize_splits")

-- Keep splits stable
vim.opt.splitkeep = "screen"
vim.opt.equalalways = false
vim.opt.tabstop = 4 -- how many spaces a <Tab> shows as
vim.opt.shiftwidth = 4 -- how many spaces for >> << and autoindent
vim.opt.expandtab = true -- turn Tab into spaces
