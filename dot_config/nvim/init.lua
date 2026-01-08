vim.opt.tabstop = 4 -- how many spaces a <Tab> shows as
vim.opt.shiftwidth = 4 -- how many spaces for >> << and autoindent
vim.opt.expandtab = true -- turn Tab into spaces
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- init.lua or config/lazy.lua
require("config.lsp")
