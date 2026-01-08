return {
  -- Глобальные настройки LSP и диагностики
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Глобальные сочетания клавиш для диагностики
      vim.keymap.set("n", "<space>do", vim.diagnostic.open_float)
      vim.keymap.set("n", "<space>dp", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "<space>dn", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<space>dl", vim.diagnostic.setloclist)

      -- Глобальные настройки диагностики
      vim.diagnostic.config({
        update_in_insert = false,
        signs = true,
        underline = true,
        virtual_text = {
          prefix = "●",
          source = "if_many",
          spacing = 5,
        },
        severity_sort = true,
      })

      -- Дополнительные глобальные команды
      vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder)
      vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder)
      vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end)
    end,
  },
}
