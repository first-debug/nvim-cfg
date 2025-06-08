require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "tsserver", "gopls", "clangd", "clangd-format" }
vim.lsp.enable(servers)
local lspconfig = require "lspconfig"

-- Настройка для TS/JS/JSX/TSX
lspconfig.ts_ls.setup {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}
-- read :h vim.lsp.config for changing options of lsp servers
