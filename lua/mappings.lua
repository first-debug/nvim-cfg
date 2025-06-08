require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set


map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Перейти в левое окно" }) -- из терминала
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Перейти в нижнее окно" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Перейти в верхнее окно" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Перейти в правое окно" })
map("t", "<C-q>", "<C-\\><C-n>:q<CR>", { desc = "Закрыть терминал" })
map("nt", "<C-q>", "<C-\\><C-n>:q<CR>", { desc = "Закрыть терминал" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
