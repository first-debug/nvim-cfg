vim.api.nvim_create_autocmd({ "BufRead" }, {
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

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()

    local opts = { buffer = buf, remap = false }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-sh>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end
})

-- Удалять пустой буфер, который появляется после создания файла в Neotree и открытия любого файла
vim.api.nvim_create_autocmd('BufHidden', {
  desc = 'Delete [No Name] buffers',
  callback = function(data)
    if data.file == '' and vim.bo[data.buf].buftype == '' and not vim.bo[data.buf].modified then
      vim.schedule(function()
        pcall(vim.api.nvim_buf_delete, data.buf, {})
      end)
    end
  end,
})

-- Настройка окна терминала
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    -- Приписка _local задает параметр только для текущего буфера
    -- vim.opt_local.number = false -- Отключаем нумерование строк
    -- vim.opt_local.relativenumber = false -- Отключаем относительное нумерование строк
    vim.opt_local.foldcolumn = "0" -- Оключаем сворачивание текста
    vim.opt_local.signcolumn = "no" -- Отключаем показ меток ошибок, маркеров отладки и т.д.

    if vim.g.lazygit_opened == 1 then
      -- vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "q", { noremap = true, silent = true }) -- в lazugit Esc закрывает некоторые второстепенные окна
      vim.api.nvim_buf_set_keymap(0, "t", "dd", "q", { noremap = true, silent = true }) -- dd закрывает layzigit
    else
      vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true }) -- Esc переключает Terminal Mode в Normal Mode
      vim.api.nvim_buf_set_keymap(0, "t", "dd", "<C-\\><C-n>", { noremap = true, silent = true }) -- dd переключает Terminal Mode в Normal Mode
    end

    vim.cmd("startinsert")
  end,
})

-- Обрезать лишние пробелы в концах строк
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.cmd([[
         keeppatterns %s/\s\+$//e
      ]])
    end,
    group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
})

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

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.asm", "*.ASM"},
  callback = function ()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local formatted_lines = {}

    for _, line in ipairs(lines) do
      if line:match("^%s*[%a_][%w_]*:%s*$") then
        -- Метки от начала строки
        formatted_lines[#formatted_lines + 1] = line:gsub("^%s+", "")
      elseif line:match("^%s*;") then
        -- Комментарии - оставляем как есть или выравниваем
        local formatted_line = string.format("%-47s%s", "", line)
        formatted_lines[#formatted_lines + 1] = formatted_line
      else
        -- Разбиваем на части: команда и операнды
        local parts = vim.split(line, "%s+", { trimempty = true })
        if #parts >= 1 then
          local command = parts[1]
          local operands = table.concat(parts, " ", 2)

          -- Форматируем: команда на 17 позиции, операнды с 25
          local formatted_line = string.format("%-8s%-8s%s", "", command, operands)
          formatted_lines[#formatted_lines + 1] = formatted_line
        else
          formatted_lines[#formatted_lines + 1] = line
        end
      end
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
  end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format({async = false})
  end
})

