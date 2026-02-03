return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = { "pyright", "lua_ls", "gopls" },
      automatic_installation = true,
    },
    config = function()
      require("mason-lspconfig").setup()
      require("lsp-configs.gopls")
      require("lsp-configs.lua_ls")
    end,
}
