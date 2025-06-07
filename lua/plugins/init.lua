return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {},
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "eslint-lsp",
        "gopls",
        "js-debug-adapter",
        "typescript-language-server",
        "clangd",
        "clangd-format",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "javascript",
        "go",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP-источник
      "hrsh7th/cmp-buffer", -- Дополнение из буфера
      "hrsh7th/cmp-path", -- Дополнение путей
      "hrsh7th/cmp-cmdline", -- Дополнение для командной строки
      "hrsh7th/cmp-nvim-lsp-signature-help", -- Помощь по сигнатурам
      "hrsh7th/cmp-vsnip", -- Для сниппетов vsnip (если используете)
      -- Альтернативные движки сниппетов (раскомментируйте нужный):
      -- "L3MON4D3/LuaSnip",        -- Для luasnip
      -- "dcampos/nvim-snippy",     -- Для snippy
      -- "honza/vim-snippets",      -- Для ultisnips
    },
    config = function()
      require "configs.cmp" -- Загружаем ваш конфиг из lua/configs/cmp.lua
    end,
  },
}
