return {
  -- Для управления LSP серверами лучше использовать Mason
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright" }, -- Добавьте другие серверы по необходимости
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
              on_attach = function(client, bufnr)
                -- Локальные настройки для конкретного буфера
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                local opts = { buffer = bufnr, remap = false }
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
              end,
            })
          end,
        },
      })
    end,
  },

  -- Дополнительные LSP утилиты
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },

  -- Глобальные настройки LSP и диагностики
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Глобальные сочетания клавиш для диагностики
      vim.keymap.set("n", "<space>do", vim.diagnostic.open_float)
      vim.keymap.set("n", "<space>dp", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "<space>dn", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

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
