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

