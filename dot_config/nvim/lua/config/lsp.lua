-- ~/.config/nvim/lua/config/lsp.lua
-- require("lspconfig").clangd.setup({
-- 	cmd = {
-- 		"clangd",
-- 		"--background-index",
-- 		"--query-driver=/usr/bin/g++,/usr/bin/gcc",
-- 	},
-- })

-- QML
require("lspconfig").qmlls.setup({
	cmd = { "/usr/lib/qt6/bin/qmlls" },
})
-- You can also add JS / TS later
