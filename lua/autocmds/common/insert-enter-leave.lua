-- Отключить подсветку результатов поиска в insert mode
local hiGroup = vim.api.nvim_create_augroup("highlight_group", { clear = false })
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  group = hiGroup,
  command = "setlocal nohlsearch",
})

-- Включить подсветку результатов поиска при выходе из insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  group = hiGroup,
  command = "setlocal hlsearch",
})

-- Адаптивный конфиг для номеров строк в текстовых буфферах: абсолютные номера строк в insert mode и относительные номера строк в normal mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[buf].filetype
    print(filetype)
    local no_number_filetypes = {
      "snacks_picker_input",
      "TelescopePrompt",
      "neo-tree-popup",
      "toggleterm",
      "dashboard",
      "telescope",
      "neo-tree",
      "NvimTree",
      "terminal",
      "lazygit",
      "prompt",    -- various prompts
      "nofile",    -- buftype=nofile
      "help",
      "qf",        -- quickfix
      "",          -- no filetype
    }

    -- Проверяем filetype
    for _, ft in ipairs(no_number_filetypes) do
      if filetype == ft then
        vim.opt_local.number = false
        -- vim.opt_local.cursorline = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        return
      end
    end
    -- Если не нашли buftype в no_number_filetypes включаем номера строк
      vim.opt_local.number = true
      vim.opt_local.cursorline = true
      vim.opt_local.relativenumber = true
      vim.opt_local.signcolumn = "yes"
  end,
})

