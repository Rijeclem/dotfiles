-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- No Delete/Change Copying
vim.keymap.set({ "n", "x" }, "d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set({ "n", "x" }, "D", '"_D', { desc = "Delete to end of line without yanking" })

vim.keymap.set({ "n", "x" }, "c", '"_c', { desc = "Change without yanking" })
vim.keymap.set({ "n", "x" }, "C", '"_C', { desc = "Change to end of line without yanking" })

vim.keymap.set({ "n" }, "x", '"_x', { desc = "Delete char(s) without yanking in NORMAL" })

vim.keymap.set("x", "p", '"_dP', { desc = "Paste without overwriting register" })

-- Override LazyVim move-line mappings (NO reindent)
vim.keymap.set("n", "<M-j>", "<Cmd>execute 'move .+' . v:count1<CR>", { desc = "Move Down (no indent)", silent = true })
vim.keymap.set(
	"n",
	"<M-k>",
	"<Cmd>execute 'move .-' . (v:count1 + 1)<CR>",
	{ desc = "Move Up (no indent)", silent = true }
)

-- Insert-mode cursor movement without leaving insert mode
vim.keymap.set("i", "<C-k>", "<C-o>gk", { noremap = true })
vim.keymap.set("i", "<C-j>", "<C-o>gj", { noremap = true })
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true })

-- exit terminal mode via Esc
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- P force inline paste
vim.keymap.set("n", "P", function()
	local text = vim.fn.getreg('"')

	-- Remove the trailing newline from a linewise yank
	text = text:gsub("\n$", "")

	-- Remove leading whitespace
	text = text:gsub("^%s+", "")

	vim.api.nvim_put({ text }, "c", false, true)
end, { desc = "Paste inline without indentation" })

-- change the variable in all file
vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, { desc = "rename variable" })
vim.keymap.set("v", "<leader>cn", function()
	vim.cmd('normal! "zy')
	local text = vim.fn.escape(vim.fn.getreg("z"), [[/\]])

	local keys = string.format(":%s/%s//gc", "%s", text)
	-- Move cursor left 4 times: over c, g, /, /
	keys = keys .. string.rep(vim.api.nvim_replace_termcodes("<Left>", true, false, true), 3)

	vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Replace selection" })

-- open in zeal
vim.keymap.set("n", "<F2>", function()
	local word = vim.fn.expand("<cword>")
	vim.fn.jobstart({ "zeal", word }, { detach = true })
end, { desc = "Open Zeal docs" })
