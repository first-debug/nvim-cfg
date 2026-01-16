-- Настройка окна терминала
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    -- Приписка _local задает параметр только для текущего буфера
    -- vim.opt_local.number = false -- Отключаем нумерование строк
    -- vim.opt_local.relativenumber = false -- Отключаем относительное нумерование строк
    vim.opt_local.foldcolumn = "0" -- Оключаем сворачивание текста
    vim.opt_local.signcolumn = "no" -- Отключаем показ меток ошибок, маркеров отладки и т.д.

    if vim.g.lazygit_opened then
      vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "q", { noremap = true, silent = true }) -- Esc закрывает layzigit
      vim.api.nvim_buf_set_keymap(0, "t", "dd", "q", { noremap = true, silent = true }) -- dd закрывает layzigit
    else
      vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true }) -- Esc переключает Terminal Mode в Normal Mode
      vim.api.nvim_buf_set_keymap(0, "t", "dd", "<C-\\><C-n>", { noremap = true, silent = true }) -- dd переключает Terminal Mode в Normal Mode
    end

    vim.cmd("startinsert")
  end,
})

