return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        winblend = 10,
        mappings = {
          i = {
            ["<Esc>"] = actions.close,
          },
          n = {
            ["<Esc>"] = actions.close,
            ["q"] = actions.close,
          },
        },
      },
    })
  end
}
