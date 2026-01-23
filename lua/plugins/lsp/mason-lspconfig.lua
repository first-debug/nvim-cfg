return {
    {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "pyright", "lua_ls", "gopls" },
      automatic_installation = true,
    },
    config = function()
      require("mason-lspconfig").setup()
      require("lsp-configs.gopls").setup()
    end,
  },
}
