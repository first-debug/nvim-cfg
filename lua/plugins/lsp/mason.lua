return {
    {
        "williamboman/mason.nvim",
        opts = {
            -- Настройка внешнего вида
            ui = {
                check_outdated_packages_on_open = true, -- Проверять автоматически наличие обновлений?
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Рамка для окна
                width = 0.8, -- Ширина окна
                height = 0.8, -- Высота окна
                -- Иконки для различных состояний пакетов
                icons = {
                    package_installed = "✓", -- Пакет установлен
                    package_pending = "➜", -- Пакет устанавливается или ожидает установку
                    package_uninstalled = "✗", -- Пакет удален или не установлен
                },
            },
            -- Настройка сочетаний клавиш (представлены стандартные значения с переводом)
            keymaps = {
                        toggle_package_expand = "<CR>", -- Раскрыть пакет
                        install_package = "i", -- Установить пакет, на котором находится курсор
                        update_package = "u", -- Переустановить/обновить пакет, на котором находится курсор
                        check_package_version = "c",  -- Проверить наличие новой версии для пакета, на котором находится курсор
                        update_all_packages = "U", -- Обновить все установленные пакеты
                        check_outdated_packages = "C", -- Проверить наличие новой версии для всех установленных пакетов
                        uninstall_package = "X", -- Удалить пакет, на котором находится курсор
                        cancel_installation = "<C-c>", -- Отменить установку пакета, на котором находится курсор
                        apply_language_filter = "<C-f>", -- Применить языковую фильтрацию
                        toggle_package_install_log = "<CR>", -- Открыть/Закрыть журнал установки пакета, на котором находится курсор
                        toggle_help = "g?", -- Открыть меню помощи
            },
        },
    },

    {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        -- Локальные настройки для конкретного буфера
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        local opts = {  }
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
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "lua_ls", "gopls" },
        automatic_installation = true, -- Автоматическая установка
        handlers = {
          -- Настройка для gopls
          ["gopls"] = function()
            vim.lsp.config.gopls.setup({
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                on_attach(client, bufnr) -- Вызов общей on_attach функции

                -- Форматирование при сохранении
                if client.supports_method("textDocument/formatting") then
                  vim.api.nvim_create_autocmd("BufWritePre", {
                    group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
                    buffer = bufnr,
                    callback = function()
                      vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                  })
                end
              end,
              settings = {
                gopls = {
                  analyses = {
                    unusedparams = true,
                  },
                  staticcheck = true,
                  gofumpt = true,
                },
              },
            })
          end,
          ['pyright'] = function()
            vim.lsp.config.pyright.setup({
              capabilities = capabilities,
            })
          end,
          -- Настройка по умолчанию для остальных серверов
          function(server_name)
            vim.lsp.config[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
            })
          end,
        },
      })
    end,
  },
}
