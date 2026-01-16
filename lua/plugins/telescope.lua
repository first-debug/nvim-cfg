local actions = require("telescope.actions")
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    opts = {
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
    }
  }
}
