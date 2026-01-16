return {
    {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "pyright", "lua_ls", "gopls" },
      automatic_installation = true, -- Автоматическая установка
    },
    config = function()
      -- Настройка для gopls
      require("lsp-configs.gopls").init()
    end,
  },
}
