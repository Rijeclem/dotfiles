-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- No Delete/Change Copying
vim.keymap.set({ "n", "x" }, "d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set({ "n", "x" }, "D", '"_D', { desc = "Delete to end of line without yanking" })

vim.keymap.set({ "n", "x" }, "c", '"_c', { desc = "Change without yanking" })
vim.keymap.set({ "n", "x" }, "C", '"_C', { desc = "Change to end of line without yanking" })

vim.keymap.set({ "n" }, "x", '"_x', { desc = "Delete char(s) without yanking in NORMAL" })

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
