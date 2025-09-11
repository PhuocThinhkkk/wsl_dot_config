vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set(
	"v",
	"<C-s>",
	"<Esc>:'<,'>w !clip.exe<CR>:lua vim.notify('Copied to clipboard!')<CR>",
	{ noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
