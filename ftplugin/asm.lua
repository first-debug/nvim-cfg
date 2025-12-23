vim.opt.shiftwidth = 8
vim.opt.expandtab = true
vim.opt.softtabstop = 8

-- Автоформатирование при сохранении
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.asm",
--   command = "lua require('custom.asm_formatter').format()",
-- })

-- Клавиша для ручного форматирования
-- vim.keymap.set("n", "<leader>f", function()
--   require('custom.asm_formatter').format()
-- end, { buffer = true })
